/*
    The main memory leak here is that sometimes when the player is not online
    we need to allocate memory for a player class in order to use it, and therefore
    we should also delete it after we have used it and stored it into the database
*/
void Game::addItemToPlayer(const std::string &recipient, uint16_t itemId)
{
    bool playerAllocated = false;
    //if the player is online we can get it direcly from the game
    Player *player = g_game.getPlayerByName(recipient);
    //if its not online
    if (!player)
    {
         playerAllocated = true;
        //create a player to store it temporarily
        player = new Player(nullptr);
        //load it from database
        if (!IOLoginData::loadPlayerByName(player, recipient))
        {
            return;
        }
    }
    //even if this creates an item in memory, it doesnt create a memory leak, since after internal add item, the  item is added to a list to 
    //decrease the reference and then delete
    Item *item = Item::CreateItem(itemId);
    if (!item)
    {
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline())
    {
        IOLoginData::savePlayer(player);
    }
    //Fix : In case we had to allocate memory for the player, delete it afterwards
    if (playerAllocated){
        delete(player);
    }
}