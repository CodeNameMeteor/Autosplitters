state("AWayOut")
{
    int isLoading : "AWayOut.exe", 0x447F074; // 256 when in loading 0 when not
    int Checkpoint : "AWayOut.exe", 0x446FCC8; // Stores the current checkpoint
    int gameStates: "AWayOut.exe", 0x4179010; //  9 during last interaction and 5 after, during countdown = 4 and 5 after
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
        {"Beginnings",              9299},
        {"The Yard",                8925},
        {"Canteen Brawl",           9247},
        {"Helping Hand",            8794}, 
        {"Work Detail",            15780},
        {"Cell Breach",            10470},
        {"Laundry Smuggle",        12159},
        {"The Way Out",             8821},
        {"Wrench Relay",           10953},
        {"Prison Escape",           5201},
        {"On The Run",              7428},
        {"Bridge Crossing",         4883},
        {"Breather",                5057},
        {"The Farmstead",           5050},
        {"The Getaway",             4910},
        {"River Run",               5130},
        {"Reunion",                 5651},
        {"Bonds",                   5589},
        {"Hazardous Hunt",          6366},
        {"Violent Questioning",     5127},
        {"Stick Up",                5054},
        {"Gun Runner",              5378},
        {"The Call",                5601},
        {"The Assassin",            6087},
        {"A New Life",              5984},
        {"Against All Odds",        5269},
        {"Lift Off",                5532},
        {"Free Fall",                 10},
        {"The Trek",                6479},
        {"Ambush",                  6283},
        {"Covering Fire",           5911},
        {"The Mansion",             5347},
        {"Jungle Road",             7647},
        {"Answers",                 7361},
        {"Canal Chase",             8266},
        {"Face Off",                8638},
        {"A Way Out",               6350}
    };
}
startup
{
    settings.Add("Beginnings", true, "Beginnings");
    settings.Add("The Yard", true, "The Yard");
    settings.Add("Canteen Brawl", true, "Canteen Brawl");
    settings.Add("Helping Hand", true, "Helping Hand");
    settings.Add("Work Detail", true, "Work Detail");
    settings.Add("Cell Breach", true, "Cell Breach");
    settings.Add("Laundry Smuggle", true, "Laundry Smuggle");
    settings.Add("The Way Out", true, "The Way Out");
    settings.Add("Wrench Relay", true, "Wrench Relay");
    settings.Add("Prison Escape", true, "Prison Escape");
    settings.Add("On The Run", true, "On The Run");
    settings.Add("Bridge Crossing", true, "Bridge Crossing");
    settings.Add("Breather", true, "Breather");
    settings.Add("The Farmstead", true, "The Farmstead");
    settings.Add("The Getaway", true, "The Getaway");
    settings.Add("River Run", true, "River Run");
    settings.Add("Reunion", true, "Reunion");
    settings.Add("Bonds", true, "Bonds");
    settings.Add("Hazardous Hunt", true, "Hazardous Hunt");
    settings.Add("Violent Questioning", true, "Violent Questioning");
    settings.Add("Stick Up", true, "Stick Up");
    settings.Add("Gun Runner", true, "Gun Runner");
    settings.Add("The Call", true, "The Call");
    settings.Add("The Assassin", true, "The Assassin");
    settings.Add("A New Life", true, "A New Life");
    settings.Add("Against All Odds", true, "Against All Odds");
    settings.Add("Lift Off", true, "Lift Off");
    settings.Add("Free Fall", true, "Free Fall");
    settings.Add("The Trek", true, "The Trek");
    settings.Add("Ambush", true, "Ambush");
    settings.Add("Covering Fire", true, "Covering Fire");
    settings.Add("The Mansion", true, "The Mansion");
    settings.Add("Jungle Road", true, "Jungle Road");
    settings.Add("Answers", true, "Answers");
    settings.Add("Canal Chase", true, "Canal Chase");
    settings.Add("Face Off", true, "Face Off");
    settings.Add("A Way Out", true, "A Way Out");
}
split
{
    //foreach (KeyValuePair<string, int> checkpoint in vars.Checkpoints)
    //{
        //if( settings[checkpoint.Key] && (current.Checkpoint != old.Checkpoint) && current.Checkpoint == checkpoint.Value ){
            //return true;
        //}
    //}
    if(current.Checkpoint != old.Checkpoint )
    {
        foreach (KeyValuePair<string, int> checkpoint in vars.Checkpoints)
        {
            if( settings[checkpoint.Key] && current.Checkpoint == checkpoint.Value ){
            return true;
            }
        }
    }
    if( current.checkpoint == 8638 && (current.gameStates == 5 && old.gameStates == 9 || current.gameStates == 4 && old.gameStates ==  8) && settings["A Way Out"]){
        return true;
    }
}
isLoading
{
    return (current.isLoading == 256);


}
start
{
    return( current.gameStates == 5 && old.gameStates == 4 );
}
onStart
{
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
}
exit
{
    //pauses timer if the game crashes
	timer.IsGameTimePaused = true;
}


