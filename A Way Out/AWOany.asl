state("AWayOut")
{
    bool isLoading : "AWayOut.exe", 0x04270920, 0x38, 0x10, 0x258, 0xA00, 0x360, 0x820, 0x48, 0x20C; //008C120C
}
state("AWayOut_friend")
{
    //bool isLoading: "AWayOut_friend.exe";
    int Checkpoint : "AWayOut_friend.exe", 0x4470CC8; //Stores the current checkpoint
}
init 
{
    vars.Checkpoints = new Dictionary<string, int>
    {
        {"Beginnings",              10},
        {"The Yard",                10},
        {"Canteen Brawl",           10},
        {"Helping Hand",            10},
        {"Work Detail",             10},
        {"Cell Breach",             10},
        {"Laundry Smuggle",         10},
        {"The Way Out",             10},
        {"Wrench Relay",            10},
        {"Prison Escape",           10},
        {"On The Run",              10},
        {"Bridge Crossing",         10},
        {"Breather",                10},
        {"The Farmstead",           10},
        {"The Getaway",             10},
        {"River Run",               10},
        {"Reunion",                 10},
        {"Bonds",                   10},
        {"Hazardous Hunt",          10},
        {"Violent Questioning",     10},
        {"Stick Up",                10},
        {"Gun Runner",              10},
        {"The Call",                10},
        {"The Assassin",            10},
        {"A New Life",              10},
        {"Against All Odds",        10},
        {"Lift Off",                10},
        {"Free Fall",               10},
        {"The Trek",                10},
        {"Ambush",                  10},
        {"Covering Fire",           10},
        {"The Mansion",             10},
        {"Jungle Road",             10},
        {"Answers",                 10},
        {"Canal Chase",             10},
        {"Face Off",                10},
        {"A Way Out",               10}
    };
}
startup
{
    foreach (KeyValuePair<string, int> checkpoint in vars.Checkpoints){
        Settings.add(checkpoint.Key, true, checkpoint.Key);
    }
}
split
{
    foreach (KeyValuePair<string, int> checkpoint in vars.Checkpoints)
    {
        if(settings[checkpoint.Key] && (current.Checkpoint != old.Checkpoint) && current.Checkpoint == checkpoint.Value ){
            return true;
        }
    }
}
isLoading
{
    return current.isLoading;

}
onStart
{
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
    vars.loading = 0;
    vars.inLevelEnd = 0;
}
exit
{
    //pauses timer if the game crashes
	timer.IsGameTimePaused = true;
}

