state("MirrorsEdgeCatalyst")
{
    bool contentActive : "MirrorsEdgeCatalyst.exe", 0x257E7C8, 0x28, 0x280; // true when in a dash/time trial
    bool loading : "MirrorsEdgeCatalyst.exe", 0x240C2B8, 0x4C1; // true when in loading screens and videos
    bool dashStarted : "MirrorsEdgeCatalyst.exe", 0x0257C9D0, 0xE0; // true when faith passes the start line
    bool inMenu: "MirrorsEdgeCatalyst.exe", 0x25946E4; // when 1 your in a menu teleporting dying whatever
    uint mission : "MirrorsEdgeCatalyst.exe", 0x0257C9D8, 0x20, 0x1858, 0x18;
}
init {
	vars.timerStarted = false;
}
split
{
    return ((!current.dashStarted  && old.dashStarted)  && (!current.inMenu) && !current.loading  );
}


start
{
    return (current.contentActive && !old.contentActive &&  !current.inMenu  && !current.loading );
}
isLoading
{
    return current.loading;
}
reset
{
	if(current.mission == 55 && old.mission == 0 && vars.timerStarted == true ) return true;
}
onStart
{
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
    vars.timerStarted = true;
}
onReset
{
    vars.timerStarted = false;
}
exit
{
    //pauses timer if the game crashes
	timer.IsGameTimePaused = true;
}

