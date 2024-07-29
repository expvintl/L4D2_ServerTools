
public int PlayerTeleportHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
			switch(param2){
				case 0:{
				PlayerSelectMenu(param1,PlayerTeleportMenuHandler);
                }
				case 1:{
				PlayerSelectMenu(param1,PlayerTeleportMenuHandler);
                }
				case 2:{
				PlayerSelectMenu(param1,PlayerTeleportMenuHandler);
                }
			}
	}
	return 0;
}
public int PlayerTeleportMenuHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
		char playerIndex[32];
		menu.GetItem(param2,playerIndex,sizeof(playerIndex));
        float pos[3];
		//如果索引是all
		if(strcmp(playerIndex,"all")==0){
		for(int i=1;i<GetMaxHumanPlayers();i++){
			if(!IsClientInGame(i)||!IsPlayerAlive(i)||GetClientTeam(i)!=2) continue;
            GetClientAbsOrigin(param1,pos);
			TeleportEntity(i,pos);
		}
		return 0;
		}
		int index=StringToInt(playerIndex);
		GetClientAbsOrigin(param1,pos);
		TeleportEntity(index,pos);
		}
	return 0;
}
public void PlayerTeleportMenu(int client){
	Menu panel=new Menu(PlayerTeleportHandler,MENU_ACTIONS_ALL);
	panel.SetTitle("玩家选项");
	panel.AddItem("warptoMe","传送到我");
    panel.ExitBackButton=true;
	panel.Display(client,60);
}