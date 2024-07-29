
public Action Command_Cvar(int client, int args)
{
	if (args < 1)
	{
		if (client == 0)
		{
			ReplyToCommand(client, "用法: sm_cvar <cvar|protect> [value]");
		}
		else
		{
			ReplyToCommand(client, "用法: sm_cvar <cvar> [value]");
		}
		return Plugin_Handled;
	}

	char cvarname[64];
	GetCmdArg(1, cvarname, sizeof(cvarname));

	ConVar hndl = FindConVar(cvarname);
	if (!hndl)
	{
		ReplyToCommand(client, "无法找到变量 %s", cvarname);
		return Plugin_Handled;
	}

	char value[255];
	if (args < 2)
	{
		hndl.GetString(value, sizeof(value));

		ReplyToCommand(client,"当前变量 %s = %s", cvarname, value);
		return Plugin_Handled;
	}

	GetCmdArg(2, value, sizeof(value));
	
	// The server passes the values of these directly into ServerCommand, following exec. Sanitize.
	if (StrEqual(cvarname, "servercfgfile", false) || StrEqual(cvarname, "lservercfgfile", false))
	{
		int pos = StrContains(value, ";", true);
		if (pos != -1)
		{
			value[pos] = '\0';
		}
	}

	if ((hndl.Flags & FCVAR_PROTECTED) != FCVAR_PROTECTED)
	{
		ReplyToCommand(client, "已更改 \"%s\" = \"%s\"", cvarname, value);
	}
	else
	{
		ReplyToCommand(client, "已更改 \"%s\" = \"%s\"", cvarname, value);
	}

	hndl.SetString(value, true);

	return Plugin_Handled;
}
