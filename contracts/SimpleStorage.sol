pragma solidity ^0.4.18;

contract SimpleStorage {
    uint itemCounter = 0;
    struct User {
        address addr;
        uint number;
        // Item[] ownedItems;
    }

    struct Item {
        uint itemId;
        string itemName;
        string itemType;
        bool checkedOut;
        bool trashed;
        address owner;
    }

    mapping (address => User) users;
    address[] userAddresses;
    mapping (uint => Item) public items;
    uint[] public itemIds;

    function SimpleStorage() public {
        addItem("accessory", "Magic Mouse 2");
        addItem("monitor", "Monitor 1");
        addItem("computer", "Macbook Pro 5");
    }

    function addItem(string _itemName, string _itemType) public {
      // adds a new item into the system, not checked out, not 'trashed'
      // do we need an external AND internal ID for the item?
        items[itemCounter] = Item(itemCounter, _itemName, _itemType, false, false, address(this));
        itemIds.push(itemCounter);
        itemCounter++;
    }

    function checkOut(uint _itemId) public {
        // Item storage item = items[_itemId];
        require(items[_itemId].owner == address(this));
        // function will return out if above statement evaluates to false
        items[_itemId].owner = msg.sender;
    }

    function checkIn() public {

    }

    function set(uint x) public {
        users[msg.sender] = User(msg.sender, 0);
    
        User storage u = users[msg.sender];
        u.number = x;
    }

    function get() public view returns (uint) {
        User storage u = users[msg.sender];
        return u.number;
    }
}
