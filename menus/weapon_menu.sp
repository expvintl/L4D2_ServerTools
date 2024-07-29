bool infAmmoTargets[32];
bool fastShot[32];

public void WeaponMenu(int client){
	Menu panel=new Menu(WeaponOptionHandler,MENU_ACTIONS_ALL);
	panel.SetTitle("武器选项");
	panel.AddItem("infAmmo","无限子弹");
	panel.AddItem("fastShot","快速射击");
	panel.Display(client,60);
}

public void FastShotMenu(int client){
    PlayerSelectMenu(client,FastShotMenuHandler);
}
public void InfAmmoMenu(int client){
	PlayerSelectMenu(client,InfAmmoMenuHandler);
}

public int WeaponOptionHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
			switch(param2){
				case 0:
				InfAmmoMenu(param1);
				case 1:
				FastShotMenu(param1);
			}
	}
	return 0;
}

public int FastShotMenuHandler(Menu menu, MenuAction action, int param1, int param2){
	char name[32];
	if(action==MenuAction_Select){
		char playerIndex[32];
		menu.GetItem(param2,playerIndex,sizeof(playerIndex));
		//如果索引是all
		if(strcmp(playerIndex,"all")==0){
		for(int i=1;i<GetMaxHumanPlayers();i++){
		if(!IsClientInGame(i)||!IsPlayerAlive(i)||GetClientTeam(i)!=2) continue;
		if((fastShot[i]=SwitchFeature(param1,i,fastShot[i],"已启用快速射击","已禁用快速射击"))){
				menu.Display(param1,60);
			}else{
				menu.Display(param1,60);
		}
		}
		return 0;
		}
		if(strcmp(playerIndex,"self")==0){
		if((fastShot[param1]=SwitchFeature(param1,param1,fastShot[param1],"已启用快速射击","已禁用快速射击"))){
				menu.Display(param1,60);
			}else{
				menu.Display(param1,60);
		}
			return 0;
		}
		int index=StringToInt(playerIndex);
		if((fastShot[index]=SwitchFeature(param1,index,fastShot[index],"已启用快速射击","已禁用快速射击"))){
				menu.Display(param1,60);
			}else{
				menu.Display(param1,60);
		}
		}
	return 0;
}
public int InfAmmoMenuHandler(Menu menu, MenuAction action, int param1, int param2){
	char name[32];
	if(action==MenuAction_Select){
		char playerIndex[32];
		menu.GetItem(param2,playerIndex,sizeof(playerIndex));
		//如果索引是all
		if(strcmp(playerIndex,"all")==0){
		for(int i=1;i<GetMaxHumanPlayers();i++){
			if(!IsClientInGame(i)||!IsPlayerAlive(i)||GetClientTeam(i)!=2) continue;
			if(!infAmmoTargets[i]){
		infAmmoTargets[i]=true;
		GetClientName(i,name,sizeof(name));
		PrintToChat(param1,"%s 已启用无限子弹!",name);
		}else{
			infAmmoTargets[i]=false;
		GetClientName(i,name,sizeof(name));
		PrintToChat(param1,"%s 已禁用无限子弹!",name);
		}
		}
		return 0;
		}
		if(strcmp(playerIndex,"self")==0){
		if(!infAmmoTargets[param1]){
		infAmmoTargets[param1]=true;
		GetClientName(param1,name,sizeof(name));
		PrintToChat(param1,"%s 已启用无限子弹!",name);
		}else{
		infAmmoTargets[param1]=false;
		GetClientName(param1,name,sizeof(name));
		PrintToChat(param1,"%s 已禁用无限子弹!",name);
		}
			return 0;
		}
		int index=StringToInt(playerIndex);
		if(!infAmmoTargets[index]){
		infAmmoTargets[index]=true;
		GetClientName(index,name,sizeof(name));
		PrintToChat(param1,"%s 已启用无限子弹!",name);
		}else{
		infAmmoTargets[index]=false;
		GetClientName(index,name,sizeof(name));
		PrintToChat(param1,"%s 已禁用无限子弹!",name);
		}
		}
	return 0;
}
