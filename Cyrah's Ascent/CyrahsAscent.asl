state("CyrahsAscent-Win64-Shipping")
{
    int cinematicDuration : "CyrahsAscent-Win64-Shipping.exe", 0x048AA9A8, 0x0, 0x20, 0x708, 0x474; // stores the duration of every cinematic, except the first for whatever reason.
    int cinematicPlaying : "CyrahsAscent-Win64-Shipping.exe", 0x04822C38, 0x78, 0x110, 0x710; // 1 when a cinematic is playing, 0 when not.
}
startup
{

    settings.Add("Fights", true, "Fights");
    settings.Add("firstFight", false, "First Fight Cutscene", "Fights");
    settings.Add("secondFight", false,"Second Fight Cutscene", "Fights" );
    settings.Add("BridgeBoss", false,"Boss On Bridge Cutscene", "Fights" );
    settings.Add("finalBossFirstPhase", false,"Final Boss Second Phase Cutscene", "Fights" );
    settings.Add("finalBossDeath", true,"Final Cutscene", "Fights" );
}
init 
{
    vars.Cinematics = new Dictionary<string, int>
    {
        {"firstFight",                  961},
        {"secondFight",                 270},
        {"BridgeBoss",                 1281},
        {"finalBossFirstPhase",         721},
        {"finalBossDeath",              931}
    };
}
split
{

    //Cutscene
    if(current.cinematicPlaying == 65537 && old.cinematicPlaying == 65536)
    {
        foreach (KeyValuePair<string, int> Cinematic in vars.Cinematics)
        {
            if(settings[Cinematic.Key] && current.cinematicDuration == Cinematic.Value){
                return true;
            }
        }
    }
}
start
{
    if(current.cinematicPlaying == 65536 && old.cinematicPlaying == 65537 ){
        return true;
    }
}
isLoading
{
    return (current.cinematicPlaying == 65537);
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

