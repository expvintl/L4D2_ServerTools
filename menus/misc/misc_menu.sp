#include "misc_prop.sp"

public void MiscMenu(int client){
	Menu panel=new Menu(MiscOptionHandler,MENU_ACTIONS_ALL);
	panel.SetTitle("杂项");
	panel.AddItem("spawn","道具生成");
	panel.AddItem("removeProp","移除准星目标");
    panel.AddItem("removeAllProp","移除所有已创建的");
    panel.AddItem("spawnMode","切换生成模式");
    panel.AddItem("switchMode","切换改变模式");
	panel.Display(client,60);
}

public int MiscOptionHandler(Menu menu, MenuAction action, int param1, int param2){
	if(action==MenuAction_Select){
			switch(param2){
				case 0:
				MiscPropMenu(param1);
				case 1:{
                    int entity=GetClientAimTarget(param1,false);
                    if(entity==-1||entity==-2) {
                        menu.Display(param1,60);
                        return 0;
                    }
                    char name[64];
                    char modelName[256];
                    GetEntityClassname(entity,name,sizeof(name));
                    GetEntPropString(entity, Prop_Data, "m_ModelName", modelName, sizeof(modelName));
                    if(strcmp(name,"player")==0){
                        if(!IsClientInGame(entity)||!IsFakeClient(entity)){
                        menu.Display(param1,60);
                        PrintToChat(param1,"你不能移除玩家!");
                        return 0;
                        }
                    }
                    PrintToChat(param1,"您移除了 %s(%s)",modelName,name);
                    RemoveEntity(entity);
                    menu.Display(param1,60);
                }
                case 2:
                CleanupSpawned(param1);
                case 3:{
                    IsSpawnPhysicsProp[param1]=SwitchFeature(param1,param1,IsSpawnPhysicsProp[param1],"已切换到生成物理对象","已切换到生成动态对象");
                }
                case 4:{
                    IsSelfModel[param1]=SwitchFeature(param1,param1,IsSelfModel[param1],"已切换到改变自己模型","已切换到生成对象");
                }
            }
    }
	return 0;
}