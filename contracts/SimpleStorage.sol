pragma solidity ^0.4.18;

contract SimpleStorage {
    uint itemCounter = 0;
    struct User {
        address addr;
        uint number;
        string firstName;
        string lastName;
        bool isManager;
        // Item[] ownedItems;
    }

    struct Item {
        uint itemId;
        string itemName;
        string itemType;
        // don't know if we need this bool since 
        // we will know what's checked out based on address
        bool checkedOut;
        bool trashed;
        address owner;
    }

    mapping (address => User) users;
    address[] userAddresses;
    mapping (uint => Item) public items;
    uint[] public itemIds;

    function SimpleStorage() public {
        // constructor -- adds 3 static items to play around with
        addItem("accessory", "Magic Mouse 2");
        addItem("monitor", "Monitor 1");
        addItem("computer", "Macbook Pro 5");
    }

    function addItem(string _itemType, string _itemName) public {
      // adds a new item into the system, not checked out, not 'trashed'
      // do we need an external AND internal ID for the item?
        items[itemCounter] = Item(itemCounter, _itemType, _itemName, false, false, address(this));
        itemIds.push(itemCounter);
        itemCounter++;
    }

    function checkOut(uint _itemId) public {
        require(items[_itemId].owner == address(this));
        // function will return out if above statement evaluates to false
        items[_itemId].owner = msg.sender;
    }

    function checkIn(uint _itemId) public {
        require(items[_itemId].owner == msg.sender);
        // function will return out if transasction sender doesn't own this item
        items[_itemId].owner = address(this);

    }
}
