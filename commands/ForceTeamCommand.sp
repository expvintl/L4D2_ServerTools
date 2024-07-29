public Action Command_ForceTeam(int client,int args){
    if(args<1){
        PrintToChat(client,"用法: /forceteam [tegan/renlei/guancha]");
        return Plugin_Handled;
    }
	char value[64];
	GetCmdArg(1, value, sizeof(value));
	if(strcmp(value,"tegan")==0){
        ChangeClientTeam(client,TEAM_ZOMBY);
        PrintToChat(client,"你已切换到特感队伍");
        return Plugin_Handled;
    }
    if(strcmp(value,"renlei")==0){
        ChangeClientTeam(client,TEAM_SURVIVOR);
        PrintToChat(client,"你已切换到生还者队伍");
        return Plugin_Handled;
    }
    if(strcmp(value,"guancha")==0){
        // SetEntProp(client,Prop_Send, "m_iTeamNum", TEAM_SPECTATOR);
        ChangeClientTeam(client,TEAM_SPECTATOR);
        PrintToChat(client,"你已切换到观察者");
        return Plugin_Handled;
    }
    return Plugin_Handled;
}