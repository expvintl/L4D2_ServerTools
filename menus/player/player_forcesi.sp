
int selectSI=0;
public int PlayerForceSIHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
		PlayerSelectMenu(param1,PlayerForceSISelectHandler);
        selectSI=param2;
	}
	if(action==MenuAction_Cancel){
		if(param2==MenuCancel_ExitBack) PlayerMenu(param1);
	}
	return 0;
}
public int PlayerForceSISelectHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
		char playerIndex[32];
		menu.GetItem(param2,playerIndex,sizeof(playerIndex));
		//如果索引是all
		if(strcmp(playerIndex,"all")==0){
		for(int i=1;i<GetMaxHumanPlayers();i++){
			if(!IsClientInGame(i)||!IsPlayerAlive(i)||GetClientTeam(i)!=2) continue;
			ForceApplySpecial(i,selectSI);
		}
		return 0;
		}
		if(strcmp(playerIndex,"self")==0){
		ForceApplySpecial(param1,selectSI);
		return 0;
		}
		int index=StringToInt(playerIndex);
		ForceApplySpecial(index,selectSI);
		}
		if(action==MenuAction_Cancel){
		if(param2==MenuCancel_ExitBack) PlayerGravityMenu(param1);
	}
	return 0;
}
public void PlayerForceSIMenu(int client){
	Menu panel=new Menu(PlayerForceSIHandler,MENU_ACTIONS_ALL);
	panel.SetTitle("强制特感");
	panel.AddItem("charger","Charger");
	panel.AddItem("jockey","Jockey");
	panel.AddItem("hunter","Hunter");
    panel.AddItem("spitter","Spitter");
    panel.AddItem("hulk","Tank");
    panel.AddItem("smoker","Smoker");
    panel.AddItem("boomer","Boomer");
    panel.AddItem("tank2","Tank2");
    panel.AddItem("l4d1Tank","Tank L4D1");
	panel.ExitBackButton=true;
	panel.Display(client,60);
}