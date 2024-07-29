
float gravityValue=0;
public int PlayerGravityHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
			switch(param2){
				case 0:{
				PlayerSelectMenu(param1,PlayerGravityMenuHandler);
                gravityValue=0.2;
                }
				case 1:{
				PlayerSelectMenu(param1,PlayerGravityMenuHandler);
                gravityValue=1.0;
                }
				case 2:{
				PlayerSelectMenu(param1,PlayerGravityMenuHandler);
                gravityValue=5.0;
                }
			}
	}
	if(action==MenuAction_Cancel){
		if(param2==MenuCancel_ExitBack) PlayerMenu(param1);
	}
	return 0;
}
public int PlayerGravityMenuHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
		char playerIndex[32];
		menu.GetItem(param2,playerIndex,sizeof(playerIndex));
		//如果索引是all
		if(strcmp(playerIndex,"all")==0){
		for(int i=1;i<GetMaxHumanPlayers();i++){
			if(!IsClientInGame(i)||!IsPlayerAlive(i)||GetClientTeam(i)!=2) continue;
			VS_SetPlayerGravity(i,gravityValue);
		}
		return 0;
		}
		if(strcmp(playerIndex,"self")==0){
			VS_SetPlayerGravity(param1,gravityValue);
			return 0;
		}
		int index=StringToInt(playerIndex);
		VS_SetPlayerGravity(index,gravityValue);
		}
		if(action==MenuAction_Cancel){
		if(param2==MenuCancel_ExitBack) PlayerGravityMenu(param1);
	}
	return 0;
}
public void PlayerGravityMenu(int client){
	Menu panel=new Menu(PlayerGravityHandler,MENU_ACTIONS_ALL);
	panel.SetTitle("玩家选项");
	panel.AddItem("low","低重力");
	panel.AddItem("normal","默认");
	panel.AddItem("hight","高重力");
	panel.ExitBackButton=true;
	panel.Display(client,60);
}