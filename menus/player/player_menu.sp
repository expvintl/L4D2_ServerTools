#include "player_gravity.sp"
#include "player_teleport.sp"
#include "player_fakelagv.sp"
#include "player_forcesi.sp"
bool inNoclip[32];
public int DefibSelectPlayerMenuHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
		char playerIndex[32];
		menu.GetItem(param2,playerIndex,sizeof(playerIndex));
		//如果索引是all
		if(strcmp(playerIndex,"all")==0){
		for(int i=1;i<GetMaxHumanPlayers();i++){
			if(!IsClientInGame(i)||IsPlayerAlive(i)||GetClientTeam(i)!=2) continue;
			RunVScript("GetPlayerFromUserID(%d).ReviveByDefib()", GetClientUserId(i));
			menu.Display(param1,60);
		}
		return 0;
		}
		if(strcmp(playerIndex,"self")==0){
			RunVScript("GetPlayerFromUserID(%d).ReviveByDefib()", GetClientUserId(param1));
			menu.Display(param1,60);
			return 0;
		}
		int index=StringToInt(playerIndex);
		RunVScript("GetPlayerFromUserID(%d).ReviveByDefib()", GetClientUserId(index));
		menu.Display(param1,60);
		}
	return 0;
}
public int NoclipPlayerMenuHandler(Menu menu, MenuAction action, int param1, int param2){
	char name[32];
	if(action==MenuAction_Select){
		char playerIndex[32];
		menu.GetItem(param2,playerIndex,sizeof(playerIndex));
		//如果索引是all
		if(strcmp(playerIndex,"all")==0){
		for(int i=1;i<GetMaxHumanPlayers();i++){
			if(!IsClientInGame(i)||!IsPlayerAlive(i)||GetClientTeam(i)!=2) continue;
			if((inNoclip[i]=SwitchFeature(param1,i,inNoclip[i],"已启用无碰撞移动","已禁用无碰撞移动"))){
				SetEntProp(i,Prop_Send,"movetype",MOVETYPE_NOCLIP);
				menu.Display(param1,60);
			}else{
				SetEntProp(i,Prop_Send,"movetype",MOVETYPE_WALK);
				menu.Display(param1,60);
			}
		}
		return 0;
		}
		if(strcmp(playerIndex,"self")==0){
			if((inNoclip[param1]=SwitchFeature(param1,param1,inNoclip[param1],"已启用无碰撞移动","已禁用无碰撞移动"))){
				SetEntProp(param1,Prop_Send,"movetype",MOVETYPE_NOCLIP);
			}else{
				SetEntProp(param1,Prop_Send,"movetype",MOVETYPE_WALK);
			}
			menu.Display(param1,60);
			return 0;
		}
		int index=StringToInt(playerIndex);
		if((inNoclip[index]=SwitchFeature(param1,index,inNoclip[index],"已启用无碰撞移动","已禁用无碰撞移动"))){
				SetEntProp(index,Prop_Send,"movetype",MOVETYPE_NOCLIP);
				menu.Display(param1,60);
			}else{
				SetEntProp(index,Prop_Send,"movetype",MOVETYPE_WALK);
				menu.Display(param1,60);
		}
		}
	return 0;
}
public int ReviveSelectPlayerMenuHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
		char playerIndex[32];
		menu.GetItem(param2,playerIndex,sizeof(playerIndex));
		//如果索引是all
		if(strcmp(playerIndex,"all")==0){
		for(int i=1;i<GetMaxHumanPlayers();i++){
			if(!IsClientInGame(i)||!IsPlayerAlive(i)||GetClientTeam(i)!=2) continue;
			RunVScript("GetPlayerFromUserID(%d).ReviveFromIncap()", GetClientUserId(i));
			menu.Display(param1,60);
		}
		return 0;
		}
		if(strcmp(playerIndex,"self")==0){
			RunVScript("GetPlayerFromUserID(%d).ReviveFromIncap()", GetClientUserId(param1));
			menu.Display(param1,60);
			return 0;
		}
		int index=StringToInt(playerIndex);
		RunVScript("GetPlayerFromUserID(%d).ReviveFromIncap()", GetClientUserId(index));
		menu.Display(param1,60);
		}
	return 0;
}

public int PlayerMenuHandler(Menu menu, MenuAction action, int param1, int param2){
	switch(action){
			case MenuAction_Select:{
			switch(param2){
				case 0:
				PlayerSelectMenu(param1,ReviveSelectPlayerMenuHandler);
				case 1:
				PlayerSelectMenu(param1,DefibSelectPlayerMenuHandler,false);
				case 2:
                PlayerGravityMenu(param1);
				case 3:
				PlayerTeleportMenu(param1);
				case 4:
				PlayerSelectMenu(param1,NoclipPlayerMenuHandler);
				case 5:
				PlayerFakeLagMenu(param1);
				case 6:
				PlayerForceSIMenu(param1);
			}
	}
	}
	if(action==MenuAction_Cancel){
		if(param2==MenuCancel_ExitBack) ShowMainMenu(param1);
	}
	return 0;
}
public void PlayerMenu(int client){
	Menu panel=new Menu(PlayerMenuHandler,MENU_ACTIONS_ALL);
	panel.SetTitle("玩家选项");
	panel.AddItem("revive","拉起玩家");
	panel.AddItem("defib","除颤玩家");
	panel.AddItem("gravity","玩家重力");
    panel.AddItem("teleprot","传送选项");
	panel.AddItem("noclip","无碰撞移动");
	panel.AddItem("fakelag","延迟伪造大师");
	panel.AddItem("forceSI","强制特感");
	panel.ExitBackButton=true;
	panel.Display(client,60);
}