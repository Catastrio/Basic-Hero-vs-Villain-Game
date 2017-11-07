list playerChoice = ["Attack", "Heal", "Charge"];
string dialogInfo = "\n Please make a choice.";

key ToucherID;
integer dialogChannel;
integer listenHandle;
integer listen_handle;

integer HPchange;
integer MPchange;

integer toggle = TRUE;
integer HP = 30;
integer MP = 10;

integer turnOrder = TRUE;

integer RandomNumber(integer min, integer max)
{
    return min + (integer)(llFrand(max - min + 1));   
}

DisplayStats()
{
    integer count;
    string h = "";
    string m = "";
    integer health = HP;
    integer mana = MP;
    h = (string)health;
    m = (string)mana;
    
 llSetText("HP: " + h + 
        "\nMP: " + m + 
        "\nLast Health Change:  " + (string)HPchange + 
        "\nLast Mana Change: " + (string)MPchange, <1,1,1>, 1.5);   
}

default
{
    state_entry()
    {
        if (HP <= 0)
        {
            llSay(0, "I have fallen to the villain! Game over.");
            llSleep(5.0);
            llSay(5, "Reset");
            llResetScript();
        }
        if (MP <= 0)
        {
            llSay(0, "I have run out of energy! Game over.");
            llSleep(5.0);
            llSay(5, "Reset");
            llResetScript();
        }


        dialogChannel = -1 - (integer)("0x" + llGetSubString( (string)llGetKey(), -7, -1) );
        listen_handle = llListen(6, "", NULL_KEY, "");

        DisplayStats();    
    }

    touch_start(integer num_detected)
    {
        if (turnOrder)
        {
        ToucherID = llDetectedKey(0);
        llListenRemove(listenHandle);
        listenHandle = llListen(dialogChannel, "", ToucherID, "");
        llDialog(ToucherID, dialogInfo, playerChoice, dialogChannel);
        llSetTimerEvent(60.0);
        }
        else{
            state two;
        }
    }
    listen(integer channel, string name, key id, string message)
    {
    if(turnOrder)
    {
        if (message == "Attack")
        {
            llSay(5, "Attack");
            turnOrder = FALSE;
            state two;
        }
        if (message == "Heal")
        {
            HPchange = RandomNumber(6, 14);
            MPchange = RandomNumber(1, 4);
            HP = HP + HPchange;
            MP = MP - MPchange;
            DisplayStats();
            llSay(5, "Heal");
            turnOrder = FALSE;
            state two;
        }
        if(message == "Charge")
        {
            MPchange = RandomNumber(4, 11);
            
            MP = MP + MPchange;
            DisplayStats();
            llSay(5, "Charge");
            turnOrder = FALSE;
            state two;
        }
    }
  }
}
state two
{
    state_entry()
    {
         if (HP <= 0)
        {
            llSay(0, "I have fallen to the hero! Game over.");
            llSleep(5.0);
            llSay(6, "Reset");
            llResetScript();
        }
        if (MP <= 0)
        {
            llSay(0, "I have run out of energy! Game over.");
            llSleep(5.0);
            llSay(6, "Reset");
            llResetScript();
        }
        listen_handle = llListen(6, "", NULL_KEY, ""); 
    }
    
    listen(integer channel, string name, key id, string message)       {
        if (message == "Reset")
            {
                llResetScript();
            }
    if(turnOrder == FALSE)
    {
        if (channel == 6)
        {
            if (message == "Attack")
            {
            HPchange = RandomNumber(3, 9);
            HP = HP - HPchange;
            DisplayStats();
            turnOrder = TRUE;
            state default;
            }
            if (message == "Mana")
            {
            MPchange = RandomNumber(1, 5);
            MP = MP - MPchange;
            DisplayStats();
            turnOrder = TRUE;
            state default;
            }
            if (message == "Heal")
            {
             turnOrder= TRUE;
             state default;
            }
            if (message == "Reset")
            {
                llResetScript();
            }
        }
    }
  }
}