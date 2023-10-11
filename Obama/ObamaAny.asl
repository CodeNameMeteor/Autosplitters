state("Obama-Win64-Shipping")
{
    int oneDead : "Obama-Win64-Shipping.exe", 0x04880130, 0x258, 0x638; // stores whether or not the 1st boss is dead
    int twoDead : "Obama-Win64-Shipping.exe", 0x04880130, 0x270, 0x638;// stores whether or not the 2nd boss is dead
    int threeDead : "Obama-Win64-Shipping.exe", 0x04D7C860, 0x30, 0x5B8, 0x288, 0xA0, 0x638;// stores whether or not the 3rd boss is dead
    int fourDead : "Obama-Win64-Shipping.exe", 0x04880130, 0x240, 0x638;// stores whether or not the 4th boss is dead
    byte StreamingLevel : "Obama-Win64-Shipping.exe", 0x04D7C328, 0xE8, 0xA8, 0x88;
}

split
{
    if(current.oneDead == 1 || current.twoDead == 1 || current.threeDead == 1 || current.fourDead == 1){
        return true;
    }
}
isLoading
{
    print(current.StreamingLevel.ToString());
    print(current.oneDead.ToString());
    print(current.twoDead.ToString());
    print(current.threeDead.ToString());
    print(current.fourDead.ToString());
    if(current.StreamingLevel == 257){
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

