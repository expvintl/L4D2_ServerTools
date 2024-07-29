int lagAmount[32];
bool enableFakeLag[32];
int currLag=0;
public int PlayerFakelagHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
			switch(param2){
				case 0:{
                    currLag=0;
				PlayerSelectMenu(param1,PlayerFakeLagMenuHandler);
                }
				case 1:{
                    currLag=1;
				PlayerSelectMenu(param1,PlayerFakeLagMenuHandler);
                }
				case 2:{
                    currLag=999;
				PlayerSelectMenu(param1,PlayerFakeLagMenuHandler);
                }
                case 3:{
                    currLag=114514;
                    PlayerSelectMenu(param1,PlayerFakeLagMenuHandler);
                }
			}
	}
	return 0;
}
public int PlayerFakeLagMenuHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
		char playerIndex[32];
		menu.GetItem(param2,playerIndex,sizeof(playerIndex));
        float pos[3];
		//如果索引是all
		if(strcmp(playerIndex,"all")==0){
		for(int i=1;i<GetMaxHumanPlayers();i++){
			if(!IsClientInGame(i)||!IsPlayerAlive(i)||GetClientTeam(i)!=2) continue;
            if((enableFakeLag[i]=SwitchFeature(param1,i,enableFakeLag[i],"已启用延迟伪造","已禁用延迟伪造"))){
				menu.Display(param1,60);
                lagAmount[i]=currLag;
                enableFakeLag[i]=true;
			}else{
				menu.Display(param1,60);
                lagAmount[i]=0;
                enableFakeLag[i]=false;
            }
		}
		return 0;
		}
        if(strcmp(playerIndex,"self")==0){
			if(!IsClientInGame(param1)) return 0;
            if((enableFakeLag[param1]=SwitchFeature(param1,param1,enableFakeLag[param1],"已启用延迟伪造","已禁用延迟伪造"))){
				menu.Display(param1,60);
                lagAmount[param1]=currLag;
                enableFakeLag[param1]=true;
			}else{
				menu.Display(param1,60);
                lagAmount[param1]=0;
                enableFakeLag[param1]=false;
            }
            return 0;
        }
		int index=StringToInt(playerIndex);
		if((enableFakeLag[index]=SwitchFeature(param1,index,enableFakeLag[index],"已启用延迟伪造","已禁用延迟伪造"))){
				menu.Display(param1,60);
                lagAmount[index]=currLag;
                enableFakeLag[index]=true;
			}else{
				menu.Display(param1,60);
                lagAmount[index]=0;
                enableFakeLag[index]=false;
            }
		}
	return 0;
}
public void PlayerFakeLagMenu(int client){
	Menu panel=new Menu(PlayerFakelagHandler,MENU_ACTIONS_ALL);
	panel.SetTitle("延迟");
	panel.AddItem("zero","0");
	panel.AddItem("1","1");
    panel.AddItem("999","999");
	panel.AddItem("114514","114514");
    panel.ExitBackButton=true;
	panel.Display(client,60);
}