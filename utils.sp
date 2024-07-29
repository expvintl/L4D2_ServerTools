#define TEAM_SPECTATOR 1
#define TEAM_SURVIVOR 2
#define TEAM_ZOMBY 3
int spawnedEntity[32][200];
int spawnIndex[32];

stock void RunVScript(char[] sCode, any ...)
{
	int iScriptLogic = INVALID_ENT_REFERENCE;
	if( iScriptLogic == INVALID_ENT_REFERENCE || !IsValidEntity(iScriptLogic) )
	{
		iScriptLogic = EntIndexToEntRef(CreateEntityByName("logic_script"));
		if( iScriptLogic == INVALID_ENT_REFERENCE || !IsValidEntity(iScriptLogic) )
		SetFailState("Could not create 'logic_script'");
		
		DispatchSpawn(iScriptLogic);
	}
	static char sBuffer[8192];
	VFormat(sBuffer, sizeof(sBuffer), sCode, 2);
	SetVariantString(sBuffer);
	AcceptEntityInput(iScriptLogic, "RunScriptCode");
	RemoveEntity(iScriptLogic);
}
public void SetCurrentPrimaryWeaponAmmo(int client,int ammo){
	new iWeapon = GetEntDataEnt2(client, FindSendPropInfo("CBasePlayer", "m_hActiveWeapon"));
	SetEntData(iWeapon, FindSendPropInfo("CBaseCombatWeapon", "m_iClip1"), ammo);
}
public void SetCurrentWeaponSpeed(int client,float speed){
	int iWeapon = GetEntDataEnt2(client, FindSendPropInfo("CBasePlayer", "m_hActiveWeapon"));
	float m_flNextPrimaryAttack = GetEntPropFloat(iWeapon, Prop_Send, "m_flNextPrimaryAttack");
	SetEntPropFloat(iWeapon, Prop_Send, "m_flNextPrimaryAttack", m_flNextPrimaryAttack - (speed / 2));
}
public int GetCurrentPlayerCount(){
	int count=0;
	for(int i=1;i<MaxClients;i++){
		if(IsClientConnected(i)&&!IsFakeClient(i)) count++;
	}
	return count;
}
public int GetPlayerItemByIndex(int client,int index){
	int iWeapon = GetEntDataEnt2(client, FindSendPropInfo("CBasePlayer", "m_hMyWeapons")+index);
	if(iWeapon==-1) return 0;
	return iWeapon;
}
public int GetPlayerItemByName(int client,char className[32]){
	char name[32];
	for(int i=0;i<64;i++){
	int iWeapon = GetEntDataEnt2(client, FindSendPropInfo("CBasePlayer", "m_hMyWeapons")+i);
	if(iWeapon==-1) continue;
	GetEntityClassname(iWeapon,name,sizeof(name));
	if(strcmp(name,className)==0){
		return iWeapon;
	}
	}
	return 0;
}
bool SwitchFeature(int client,int target,bool v,char on_desc[64],char off_desc[64]){
	char name[32];
	if(!v){
	GetClientName(target,name,sizeof(name));
	PrintToChat(client,"%s %s",name,on_desc);
	return true;
	}else{
	GetClientName(target,name,sizeof(name));
	PrintToChat(client,"%s %s",name,off_desc);
	return false;
	}
}
void VS_GivePlayerItem(int client,char itemName[32],int skin=0){
	RunVScript("GetPlayerFromUserID(%d).GiveItemWithSkin(\"%s\",%d);", GetClientUserId(client),itemName,skin);
}
void VS_SetPlayerGravity(int client,float gravity){
	RunVScript("GetPlayerFromUserID(%d).SetGravity(%f)", GetClientUserId(client),gravity);
}
void VS_DropCurrentWeapon(int client){
	char className[32];
	int iWeapon = GetEntDataEnt2(client, FindSendPropInfo("CBasePlayer", "m_hActiveWeapon"));
	if(iWeapon==INVALID_STRING_INDEX) return;
	GetEntityClassname(iWeapon,className,sizeof(className));
	RunVScript("GetPlayerFromUserID(%d).DropItem(\"%s\");", GetClientUserId(client),className);
}
public bool:TraceEntityFilterPlayer(entity, contentsMask) 
{
    return entity > MaxClients;
} 
bool GetAimPos(int client,float pos[3]){
	float eye_pos[3];
	float angel[3];
	GetClientEyePosition(client,eye_pos);
	GetClientEyeAngles(client,angel);
	Handle trace=TR_TraceRayFilterEx(eye_pos,angel,MASK_SHOT_HULL,RayType_Infinite,TraceEntityFilterPlayer);
	if(TR_DidHit(trace)){
		TR_GetEndPosition(eye_pos,trace);
		CloseHandle(trace);
		pos=eye_pos;
		return true;
	}
	CloseHandle(trace);
	return false;
}

void SpawnPropInAim(int client,char propName[64],bool physicsProp=false){
	if(spawnIndex[client]>=200){
		PrintToChat(client,"生成已达上限，请清空后重试!");
		return;
	}
	float p[3];
	bool isOK=GetAimPos(client,p);
	float angel[3];
	GetClientAbsAngles(client,angel);
	if(!isOK) return;
	int ent;
	if(physicsProp) {
		ent=CreateEntityByName("prop_physics_override");
		SetEntityMoveType(ent, MOVETYPE_VPHYSICS);
	}else{
		ent=CreateEntityByName("prop_dynamic_override");
	}
	PrecacheModel(propName);
	DispatchKeyValue(ent,"model",propName);
	if(physicsProp){
		SetEntProp(ent, Prop_Data, "m_CollisionGroup", 2)
	}
	DispatchKeyValue(ent,"Solid","6");
	DispatchKeyValue(ent,"spawnflags","8");
	DispatchSpawn(ent);
	TeleportEntity(ent,p,angel);
	spawnedEntity[client][spawnIndex[client]]=ent;
	spawnIndex[client]++;
}
void CleanupSpawned(int client){
	for(int i=0;i<200;i++){
		int ent=spawnedEntity[client][i];
		if(ent<=0) continue;
		RemoveEntity(ent);
		spawnedEntity[client][i]=0;
		spawnIndex[client]=0;
	}
}
void ChangePlayerModel(int client,char model[64]){
	//没缓存预缓存
	if(!IsModelPrecached(model)){
		PrecacheModel(model);
	}
    SetEntityModel(client,model);
}
char abilitys[8][32]={"ability_charge","ability_leap","ability_lunge","ability_spit","ability_throw","ability_tongue","ability_vomit","ability_throw"};
char specials[9][64]={"models/infected/charger.mdl","models/infected/jockey.mdl","models/infected/hunter.mdl","models/infected/spitter.mdl","models/infected/hulk.mdl","models/infected/smoker.mdl","models/infected/boomer.mdl","models/infected/hulk_dlc3.mdl","models/infected/hulk_l4d1.mdl"};
char specialWeapon[8][32]={"weapon_charger_claw","weapon_jockey_claw","weapon_hunter_claw","weapon_spitter_claw","weapon_tank_claw","weapon_smoker_claw","weapon_boomer_claw","weapon_tank_claw"};
void ForceApplySpecial(int client,int abilityIndex){
	ChangePlayerModel(client,specials[abilityIndex]);
	if(abilityIndex<=8){
	int mywp=GetPlayerWeaponSlot(client,0);
	if(mywp!=-1){
	RemoveEntity(mywp);
	}
	//强制装备
    EquipPlayerWeapon(client,GivePlayerItem(client,specialWeapon[abilityIndex]));
	//创建能力实体
    int ent=CreateEntityByName(abilitys[abilityIndex]);
	if(ent!=INVALID_STRING_INDEX){
    DispatchSpawn(ent);
    SetEntPropEnt(ent,Prop_Data,"m_owner",client);
    SetEntPropEnt(client,Prop_Send,"m_customAbility",ent);
	}
	}
}