state("Obama-Win64-Shipping")
{
    int oneIsDead : "Obama-Win64-Shipping.exe", 0x04D7C860, 0x30, 0x5B0, 0x638; // stores whether or not the 1st boss is dead
    int twoIsDead : "Obama-Win64-Shipping.exe", 0x04D7C860, 0x30, 0x5C0, 0x638;// stores whether or not the 2nd boss is dead
    //int threeIsDead : "Obama-Win64-Shipping.exe", 0x04D7C860, 0x30, 0x5B8, 0x288, 0xA0, 0x638;// stores whether or not the 3rd boss is dead
    int threeIsDead : "Obama-Win64-Shipping.exe", 0x04D7C860, 0x30, 0x5B8, 0x638;// stores whether or not the 3rd boss is dead
    //int fourIsDead : "Obama-Win64-Shipping.exe", 0x04880130, 0x240, 0x638;// stores whether or not the 4th boss is dead
    int fourIsDead : "Obama-Win64-Shipping.exe", 0x04D7C860, 0x30, 0x5C8,  0x638;// stores whether or not the 4th boss is dead
    //byte StreamingLevel : "Obama-Win64-Shipping.exe", 0x04D7C328, 0xE8, 0xA8, 0x88;
    //int inMenu : "Obama-Win64-Shipping.exe", 0x04C4F2A0, 0x30, 0x174;// 1 when in any sort of menu, including loading screens. 0 When not
    int checkpoint : "Obama-Win64-Shipping.exe", 0x04D8F8D8, 0x8, 0x148, 0x4D0;
}
startup
{
    settings.Add("Bosses", true, "Boss Kills");
    settings.Add("Snake", true, "The Bone-Touched Serpent", "Bosses");
    settings.Add("Harold", true, "The Hobbled One", "Bosses");
    settings.Add("Bird", true, "Tempest, The Matriarch", "Bosses");
    settings.Add("Moon", true, "The Oracle", "Bosses");
    settings.Add("Checkpoints", false, "Checkpoints");
    settings.Add("snakeCheckpoint", false, "Checkpoint After The Bone-Touched Serpent", "Checkpoints");
    settings.Add("haroldCheckpoint", false,"Checkpoint Before The Hobbled One", "Checkpoints" );
    settings.Add("castleCheckpoint", false,"Checkpoint in Dolus Ekklisia", "Checkpoints" );
    settings.Add("secondCastleCheckpoint", false,"Second Checkpoint in Dolus Ekklisia", "Checkpoints" );
    settings.Add("platformCheckpoint", false,"Checkpoint at the Elevator", "Checkpoints" );
    settings.Add("birdCheckpoint", false,"Checkpoint Before Tempest, The Matriarch", "Checkpoints" );
    settings.Add("moonCheckpoint", false,"Checkpoint on the Moon", "Checkpoints" );
    settings.Add("oracleCheckpoint", false,"Checkpoint Before The Oracle", "Checkpoints" );
}
init 
{
    vars.Checkpoints = new Dictionary<string, int>
    {
        {"snakeCheckpoint",                 1},
        {"haroldCheckpoint",                2},
        {"castleCheckpoint",                3},
        {"secondCastleCheckpoint",          4},
        {"platformCheckpoint",              5}, 
        {"birdCheckpoint",                  6},
        {"moonCheckpoint",                  7},
        {"oracleCheckpoint",                8}
    };
}
split
{
    //Boss Kills
    if((current.oneIsDead == 1 && old.oneIsDead == 0 && settings["Snake"]) || (current.twoIsDead == 1 && old.twoIsDead == 0 && settings["Harold"]) || (current.threeIsDead == 1 && old.threeIsDead == 0 && settings["Bird"]) || (current.fourIsDead == 1 && old.fourIsDead == 0 && settings["Moon"])){
        return true;
    }
    //Checkpoints
    if(current.checkpoint != old.checkpoint && old.checkpoint != -1 )
    {
        foreach (KeyValuePair<string, int> Checkpoints in vars.Checkpoints)
        {
            if(settings[Checkpoints.Key] && current.checkpoint == Checkpoints.Value){
                return true;
            }
        }
    }
}
start
{
    if(current.checkpoint != old.checkpoint && old.checkpoint == -1 ){
        return true;
    }
}
onStart
{
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = false;
}
exit
{
    //pauses timer if the game crashes
	timer.IsGameTimePaused = true;
}

