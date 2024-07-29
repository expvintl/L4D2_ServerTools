public Action Command_RemoveLobby(int client,int args){
    FindConVar("sv_allow_lobby_connect_only").SetBool(false);
	//释放大厅
	ServerCommand("sm_l4dd_unreserve");
    PrintToChat(client,"已移除大厅!");
	return Plugin_Handled;
}