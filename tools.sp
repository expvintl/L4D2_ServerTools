
#include <sourcemod>
#include <sdktools>
#include <menus>
#include "sql/main.sp"
#include "menus/main.sp"
#include "utils.sp"
#include "commands/Commands.sp"
public Plugin myinfo =
{
	name = "MyTools",
	author = "expvintl",
	description = "Basic Tools",
	version = "v1.2",
	url = "None"
};
public Action OnPlayerRunCmd(int client, int& buttons, int& impulse, float vel[3], float angles[3], int& weapon, int& subtype, int& cmdnum, int& tickcount, int& seed, int mouse[2]){
	if (IsClientInGame(client) && !IsFakeClient(client) && IsPlayerAlive(client) && GetClientTeam(client) == 2)
	{
		if (buttons & IN_ATTACK)
		{
			//无限子弹
		if(infAmmoTargets[client]) SetCurrentPrimaryWeaponAmmo(client,10);
		if(fastShot[client]) SetCurrentWeaponSpeed(client,0.05);
		}
	}
	if(enableFakeLag[client]){
		SetEntProp(GetPlayerResourceEntity(), Prop_Send, "m_iPing",lagAmount[client],_,client);
	}
	return Plugin_Continue;
}
public void OnPluginStart()
{
	RegisterCommands();
	//InitDataBase();
	CreateTimer(8.0,UnReserveHandle);
}
public void OnClientConnected(int client){
	GameRules_SetProp("m_iServerRank",1);
	GameRules_SetProp("m_iServerPlayerCount",5102+client);
	if(!IsFakeClient(client)){
	char playerName[64];
	GetClientName(client,playerName,64);
	PrintToChatAll("玩家 %s 正在加入游戏",playerName);
	}
}
public Action UnReserveHandle(Handle timer){
	//如果仅大厅连接 并且预留大厅被删除
	if(GetConVarBool(FindConVar("sv_hosting_lobby"))||GetCurrentPlayerCount()>=1){
		FindConVar("sv_allow_lobby_connect_only").SetBool(false);
		//释放大厅
		ServerCommand("sm_l4dd_unreserve");
	}
	CreateTimer(8.0,UnReserveHandle);
	return Plugin_Handled;
}

public void OnClientDisconnect(int client){
	infAmmoTargets[client]=false;
	fastShot[client]=false;
	enableFakeLag[client]=false;
	IsSpawnPhysicsProp[client]=false;
	lagAmount[client]=0;
	CleanupSpawned(client);
	IsSelfModel[client]=false;
	//没人并且已经移除预留大厅后
	if(GetCurrentPlayerCount()<=0){
		//强制大厅连接
		FindConVar("sv_allow_lobby_connect_only").SetBool(true);
		//关闭强制加入
		PrintToServer("已恢复大厅!");
	}
}