
contract fileInfo {
    
    struct discuss {
        address user;
        bytes32 nickname;
        bytes32 context;
        uint32 praise;
        uint256 time;
    }
    
    struct videoInfo {
        bytes32 videoHash;
        bytes32 imgHash;
        address author;
        // category: video,live
        bytes32 category;
        // video name
        bytes32 title;
        bytes32 tags;
        // isuer time & video ID
        uint256 time;
        // price type: free,vip,first
        // coin: U.S. dollar
        // type:vip,coin:usd,price:0.35
        bytes32 price;
        uint32 praise;
        uint64 viewCount;
        // 0 disabled; 1 normal; new item default 1
        uint8 status;
        bytes32 memo;
    }
    
    modifier onlyAuthor(bytes32 _videoHash){
        address _customer = msg.sender;
        require(videoMap[_videoHash].author == _customer);
        _;
    }
    
    modifier videoOwner(bytes32 _videoHash){
        address _customer = msg.sender;
        require(videoMap[_videoHash].author == _customer || administrators[keccak256(abi.encodePacked(_customer))]);
        _;
    }
    
    modifier onlyAdministrator(){
        address _customerAddress = msg.sender;
        require(administrators[keccak256(abi.encodePacked(_customerAddress))]);
        _;
    }

    bytes32[] videoHashSet;
    mapping(bytes32 => videoInfo) videoMap;
    mapping(bytes32 => discuss[]) discussMap;
    mapping(address => bytes32[]) myVideoMap;
    address emptyAddress = 0x0000000000000000000000000000000000000000;
    // administrator list (see above on what they can do)
    mapping(bytes32 => bool) public administrators;
    
    constructor() public{
        // add administrators here [RC1 458]
        administrators[0x7818cf405bdd8da4725cdfc3d83990bd9ae128b2a26c8d647e80b57afcdf8596] = true;
    }
    
    /**
     * In case one of us dies, we need to replace ourselves.
     */
    function setAdministrator(bytes32 _identifier, bool _status)
        onlyAdministrator()
        public
    {
        administrators[_identifier] = _status;
    }
    
    /// Give $(toVoter) the right to vote on this ballot.
    /// May only be called by $(chairperson).
    function pushVideo(
        bytes32 _videoHash,
        bytes32 _imgHash,
        address _author,
        bytes32 _category,
        bytes32 _title,
        bytes32 _tags,
        bytes32 _price,
        bytes32 _memo) public {
        
        videoInfo memory videoInfo_item;
        videoInfo_item.videoHash = _videoHash;
        videoInfo_item.imgHash = _imgHash;
        videoInfo_item.author = _author;
        videoInfo_item.category = _category;
        videoInfo_item.title = _title;
        videoInfo_item.tags = _tags;
        videoInfo_item.price = _price;
        videoInfo_item.time = now;
        videoInfo_item.status = 1;
        videoInfo_item.memo = _memo;
        
        videoMap[_videoHash] = videoInfo_item;
        
        // push video hash to video hash set
        videoHashSet.push(_videoHash);
        
        if (_author != emptyAddress){
            myVideoMap[_author].push(_videoHash);   
        }
    }
    
    function pushVideoView(bytes32 _videoHash) public {

        videoMap[_videoHash].viewCount +=1;
    }
    
    
    function pushVideoPraise(bytes32 _videoHash) public {

        videoMap[_videoHash].praise +=1;
    }
    
    // 0 disabled; 1 normal;
    function setVideoStatus(bytes32 _videoHash, uint8 _status)
    videoOwner(_videoHash)
    payable 
    public {
 
        videoMap[_videoHash].status = _status;
    }
    
    function setVideoPrice(bytes32 _videoHash, bytes32 _price)
    videoOwner(_videoHash) 
    payable 
    public {
 
        videoMap[_videoHash].price = _price;
    }
    
    /**discuss*/
    function pushDiscuss(
        bytes32 _videoHash,
        address _user,
        bytes32 _nickname,
        bytes32 _context
        ) public {
            require(videoMap[_videoHash].author!= emptyAddress);
            discuss memory discuss_item;
            discuss_item.user = _user;
            discuss_item.nickname = _nickname;
            discuss_item.context = _context;
            discuss_item.time = now;
            
            discussMap[_videoHash].push(discuss_item);
        }
        
    function pushVideoDiscussPraise(bytes32 _videoHash, uint _discussID) public {
        require(discussMap[_videoHash][_discussID].user != emptyAddress);
        discussMap[_videoHash][_discussID].praise +=1;
    }
    
    function getVideoDiscussLength(bytes32 _videoHash) public view 
    returns(uint256){
        return discussMap[_videoHash].length;
    }
    
    function getVideoDiscuss(bytes32 _videoHash, uint _discussID) public view 
    returns(
        address,
        bytes32,
        bytes32,
        uint32,
        uint256){
            require(discussMap[_videoHash].length>0,'nothing');
            return (
                discussMap[_videoHash][_discussID].user,
                discussMap[_videoHash][_discussID].nickname,
                discussMap[_videoHash][_discussID].context,
                discussMap[_videoHash][_discussID].praise,
                discussMap[_videoHash][_discussID].time);
        }
        
    /**myVideo*/
    function getMyVideoLength(address _author) public view 
    returns(uint256){
        return myVideoMap[_author].length;
    }
    
    function getMyVideoHashByID(address _author, uint _ID) public view 
    returns (bytes32) {
            require(myVideoMap[_author].length>_ID,'nothing');
            return myVideoMap[_author][_ID];
        }
        
    /**video*/    
    function getVideoCount() public view returns(uint) {
        
        return videoHashSet.length;
    }
    
    function getVideoInfoByIndex(uint _index) public view
     returns(
            bytes32,
            bytes32,
            bytes32,
            uint32,
            bytes32,
            bytes32,
            uint256,
            uint64) {
                bytes32 setHash = videoHashSet[_index];
                require(videoMap[setHash].status!=0,'disabled');
                bytes32 imgHash_=videoMap[setHash].imgHash;
                bytes32 price_=videoMap[setHash].price;
                uint32 praise_=videoMap[setHash].praise;
                bytes32 title_=videoMap[setHash].title;
                bytes32 tags_=videoMap[setHash].tags;
                uint256 time_=videoMap[setHash].time;
                uint64 viewCount_=videoMap[setHash].viewCount;
        return (
            setHash,
            imgHash_,
            price_,
            praise_,
            title_,
            tags_,
            time_,
            viewCount_
            );
    }
    
    function getVideoInfoEXByIndex(uint _index) public view
     returns(
            bytes32,
            address,
            bytes32,
            uint,
            bytes32) {
                bytes32 setHash = videoHashSet[_index];
                address author_=videoMap[setHash].author;
                bytes32 category_=videoMap[setHash].category;
                uint8 status_=videoMap[setHash].status;
                bytes32 memo_=videoMap[setHash].memo;
        return (
            setHash,
            author_,
            category_,
            status_,
            memo_
            );
    }
    
    
    function getVideoInfoByHash(bytes32 _videoHash) public view 
        returns(
            bytes32,
            bytes32,
            bytes32,
            bytes32,
            uint256,
            uint32,
            uint8) {
        return (
            videoMap[_videoHash].videoHash,
            videoMap[_videoHash].imgHash,
            videoMap[_videoHash].title,
            videoMap[_videoHash].tags,
            videoMap[_videoHash].time,
            videoMap[_videoHash].praise,
            videoMap[_videoHash].status
            );
    }
}