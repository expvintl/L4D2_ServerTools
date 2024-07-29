
public Action Command_Kick(int client,int args){
	int maxPlayers=GetMaxHumanPlayers();
	char playerName[64];
	if(args<1){
		ReplyToCommand(client,"当前玩家:")
		for(int i=1;i<maxPlayers;i++){
			//确保是连接的用户
			if(IsClientInGame(i)){
				GetClientName(i,playerName,64);
				ReplyToCommand(client,"%d -> %s",i,playerName);
			}
		}
		return Plugin_Handled;
	}
	char value[4];
	GetCmdArg(1, value, sizeof(value));
	KickClient(StringToInt(value),"VAC banned from secure server");
	return Plugin_Handled;
}