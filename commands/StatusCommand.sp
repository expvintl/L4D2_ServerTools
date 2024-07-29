public Action Command_Status(int client,int args){
	if(client==0) return Plugin_Continue;
	char mapName[32];
	char hostname[64];
	char playerName[32];
	char authID[64];
	GetCurrentMap(mapName,sizeof(mapName));
	GetConVarString(FindConVar("hostname"), hostname, sizeof(hostname));
	PrintToConsole(client,"%s\n当前地图:%s\n人数:%d/%d | 客户端数量:%d",hostname,mapName,GetCurrentPlayerCount(),GetMaxHumanPlayers(),GetClientCount());
	PrintToConsole(client,"-----------------------------------------------");
	for(int i=1;i<MaxClients;i++){
	if(!IsClientConnected(i)||IsFakeClient(i)) continue;
	GetClientName(i,playerName,sizeof(playerName));
	float latency=GetClientLatency(i,NetFlow_Both);
	float loss=GetClientAvgLoss(i,NetFlow_Both);
	GetClientAuthId(i,AuthId_Steam2,authID,sizeof(authID));
	PrintToConsole(client,"%s(%d)\t%s\t延迟:%.1f ms/丢包:%.1f ms\t速率:%d",playerName,GetClientUserId(i),authID,latency*1000,loss*1000,GetClientDataRate(i));
	}
	PrintToConsole(client,"-----------------------------------------------");
	return Plugin_Handled;
}
