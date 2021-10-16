
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Queue {
    mapping (uint8 => string) public queue;
    uint8 firstMember = 1;
    uint8 lastMember = 0;

    constructor() public 
    {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier checkOwnerAndAccept 
    {
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        _;
    }

    function pushInQueue(string newMember) public checkOwnerAndAccept 
    {
        lastMember++;
        queue[lastMember] = newMember;
    }

    function exitQueue() public checkOwnerAndAccept
    {
        require(lastMember >= firstMember);
        delete queue[firstMember];
        firstMember++;
    }
}
