
#include "menus/give_menu.sp"
#include "menus/weapon_menu.sp"
#include "menus/player/player_menu.sp"
#include "misc/misc_menu.sp"
char admins[2][32]={
	"STEAM_1:0:12345", //Admin List
	"STEAM_1:1:54321",
}
public void ShowMainMenu(int client){
	Menu menu=new Menu(MenuHandler,MENU_ACTIONS_ALL);
	menu.SetTitle("高级菜单");
	menu.AddItem("giveweapon","给予武器");
	menu.AddItem("PlayerOption","玩家选项");
	menu.AddItem("WeaponOption","武器选项");
	menu.AddItem("miscOption","杂项");
	menu.AddItem("restartround","重启回合");
	menu.AddItem("voteNo","否定当前投票");
	menu.AddItem("voteYes","通过当前投票");
	menu.Display(client,60);
}
public Action Command_Tools(int client,int args){
	char authId[32];
	GetClientAuthId(client,AuthId_Steam2,authId,sizeof(authId));
	for(int i=0;i<sizeof(admins);i++){
	if(strcmp(admins[i],authId)!=0) continue;
	PrintToServer("Admin Open Menu:%s",authId);
	LogMessage("打开菜单:%s",authId);
	ShowMainMenu(client);
	}
	return Plugin_Handled;
}

public int MenuHandler(Menu menu, MenuAction action, int param1, int param2){
		if(action==MenuAction_Select){
			switch(param2){
				case 0:
				BuildGiveMenu(param1);
				case 1:
				PlayerMenu(param1);
				case 2:
				WeaponMenu(param1);
				case 3:
				MiscMenu(param1);
				case 4:{
				char authID[32];
				GetClientAuthId(param1,AuthId_Steam2,authID,sizeof(authID));
				if(strcmp(authID,admins[0])==0||strcmp(authID,admins[1])==0){
						ServerCommand("sm_cvar mp_restartgame 1");
					}
				}
				case 5:{
					for(int i=1;i<MaxClients;i++){
						if(IsClientInGame(i)&&!IsFakeClient(i)){
							FakeClientCommand(i,"Vote No");
						}
					}
				}
				case 6:{
					for(int i=1;i<MaxClients;i++){
						if(IsClientInGame(i)&&!IsFakeClient(i)){
							FakeClientCommand(i,"Vote Yes");
						}
					}
				}
			}
		}
		return 0;
}

void PlayerSelectMenu(int client,MenuHandler handler,bool alive=true){
    Menu menu=new Menu(handler,MENU_ACTIONS_ALL);
	menu.SetTitle("选择玩家");
	char name[32]="unname";
	char index[3];
	menu.AddItem("self","自己");
	menu.AddItem("all","所有人");
	for(int i=1;i<GetMaxHumanPlayers();i++){
		if(!IsClientInGame(i)||GetClientTeam(i)!=2||client==i) continue;
		if(!alive&&IsPlayerAlive(i)) continue;
		GetClientName(i,name,sizeof(name));
		IntToString(i,index,sizeof(index));
		menu.AddItem(index,name);
	}
	menu.ExitBackButton=true;
	menu.Display(client,60);
}