
Database g_Database=null;
void InitDataBase(){
    Database.Connect(SqlConnect,"storage-local");
    
}
public void SqlConnect(Database db,const char[] error,any data){
    if(db==null){
        PrintToServer("数据库无法加载!");
        return;
    }
    g_Database=db;
    PrintToServer("已连接到数据库!");
    return;
}