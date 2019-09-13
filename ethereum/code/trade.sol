pragma solidity ^0.5.2;

/** @title -trade v1100
 * 
 * 
 *       ::::::::::::::::::: ::::::::::::::::::::::::::::: :::       ::::::::  :::::::: :::    ::: 
 *      :+:       :+:    :+::+:       :+:       :+:    :+::+:      :+:    :+::+:    :+::+:   :+:   
 *     +:+       +:+    +:++:+       +:+       +:+    +:++:+      +:+    +:++:+       +:+  +:+     
 *    :#::+::#  +#++:++#: +#++:++#  +#++:++#  +#++:++#+ +#+      +#+    +:++#+       +#++:++       
 *   +#+       +#+    +#++#+       +#+       +#+    +#++#+      +#+    +#++#+       +#+  +#+       
 *  #+#       #+#    #+##+#       #+#       #+#    #+##+#      #+#    #+##+#    #+##+#   #+#       
 * ###       ###    ################################ ##################  ######## ###    ###       
 *
 * 
 * 
 *
 *   ____o__ __o____   o__ __o                o           o__ __o        o__ __o__/_ 
 *    /   \   /   \   <|     v\              <|>         <|     v\      <|    v      
 *         \o/        / \     <\             / \         / \     <\     < >          
 *          |         \o/     o/           o/   \o       \o/       \o    |           
 *         < >         |__  _<|           <|__ __|>       |         |>   o__/_       
 *          |          |       \          /       \      / \       //    |           
 *          o         <o>       \o      o/         \o    \o/      /     <o>          
 *         <|          |         v\    /v           v\    |      o       |           
 *         / \        / \         <\  />             <\  / \  __/>      / \  _\o__/_ 
 *
 * 
 *
 *             ╔═╗┌─┐┌─┐┬┌─┐┬┌─┐┬   ┌─────────────────────────┐ ╦ ╦┌─┐┌┐ ╔═╗┬┌┬┐┌─┐ 
 *             ║ ║├┤ ├┤ ││  │├─┤│   │ https://freeblock.luxe  │ ║║║├┤ ├┴┐╚═╗│ │ ├┤  
 *             ╚═╝└  └  ┴└─┘┴┴ ┴┴─┘ └─┬─────────────────────┬─┘ ╚╩╝└─┘└─┘╚═╝┴ ┴ └─┘ 
 *   ┌────────────────────────────────┘                     └──────────────────────────────┐
 *   │╔═╗┌─┐┬  ┬┌┬┐┬┌┬┐┬ ┬   ╔╦╗┌─┐┌─┐┬┌─┐┌┐┌   ╦┌┐┌┌┬┐┌─┐┬─┐┌─┐┌─┐┌─┐┌─┐   ╔═╗┌┬┐┌─┐┌─┐┬┌─│
 *   │╚═╗│ ││  │ │││ │ └┬┘ ═  ║║├┤ └─┐││ ┬│││ ═ ║│││ │ ├┤ ├┬┘├┤ ├─┤│  ├┤  ═ ╚═╗ │ ├─┤│  ├┴┐│
 *   │╚═╝└─┘┴─┘┴─┴┘┴ ┴  ┴    ═╩╝└─┘└─┘┴└─┘┘└┘   ╩┘└┘ ┴ └─┘┴└─└  ┴ ┴└─┘└─┘   ╚═╝ ┴ ┴ ┴└─┘┴ ┴│
 *   │    ┌──────────┐           ┌───────┐            ┌─────────┐              ┌────────┐  │
 *   └────┤ Inventor ├───────────┤ Justo ├────────────┤ Sumpunk ├──────────────┤ Mantso ├──┘
 *        └──────────┘           └───────┘            └─────────┘              └────────┘
 *   ┌─────────────────────────────────────────────────────────┐ ╔╦╗┬ ┬┌─┐┌┐┌┬┌─┌─┐  ╔╦╗┌─┐
 *   │ More stable than ever, having withstood severe testnet, │  ║ ├─┤├─┤│││├┴┐└─┐   ║ │ │
 *   │ abuse and attack attempts from our community.           │  ╩ ┴ ┴┴ ┴┘└┘┴ ┴└─┘   ╩ └─┘
 *   │ Audited, tested, and approved by known community        └───────────────────────────┐
 *   │ security specialists such as tocsick and Arc. New functionality; you can now perform│ 
 *   │ partial sell orders. If you succumb to weak hands,you don't have to dump all of your│
 *   │ bags! New functionality; you can now transfer tokens between wallets.               │
 *   │ Trading is now possible from within the contract!                                   │
 *   └─────────────────────────────────────────────────────────────────────────────────────┘
 * 
 * 
 * The new dev team consists of seasoned, professional developers and has been audited by veteran solidity experts.
 * Additionally, two independent testnet iterations have been used by hundreds of people; not a single point of failure was found.
 * 
 * 
 */


contract trade {
    
    /*=================================
    =            MODIFIERS            =
    =================================*/
    
    // only people with tokens
    modifier onlyBagholders() {
        require(myTokens() > 0);
        _;
    }
    
    // only people with profits
    modifier onlyStronghands() {
        require(myDividends(true) > 0);
        _;
    }
    
    // token supply should be greater than zero
    modifier bagTokenSupply() {
        require(tokenSupply_ > 0);
        _;
    }
    
    // TokenSupply should be less than the upper limit
    modifier TokenSupplyLessLimit() {
        require(tokenSupply_ < PurchaseLimit);
        _;
    }
    
    // administrators can:
    // -> change the name of the contract
    // -> change the name of the token
    // -> change the PoS difficulty (How many tokens it costs to hold a masternode, in case it gets crazy high later)
    // they CANNOT:
    // -> take funds
    // -> disable withdrawals
    // -> kill the contract
    // -> change the price of tokens
    modifier onlyAdministrator(){
        address _customerAddress = msg.sender;
        require(administrators[keccak256(abi.encodePacked(_customerAddress))]);
        _;
    }
    
    // EXadministrators can:
    // -> change the purchase value limit of the contract
    modifier onlyEXAdministrator(){
        address _customerAddress = msg.sender;
        require(EXadministrators[keccak256(abi.encodePacked(_customerAddress))]);
        _;
    }
    
    // ensures that the first tokens in the contract will be equally distributed
    // meaning, no divine dump will be ever possible
    // result: healthy longevity.
    modifier antiEarlyWhale(uint256 _amountOfEthereum){
        address _customerAddress = msg.sender;
        
        // are we still in the vulnerable phase?
        // if so, enact anti early whale protocol 
        if( onlyAmbassadors && ((totalEthereumBalance() - _amountOfEthereum) <= ambassadorQuota_ )){
            require(
                // is the customer in the ambassador list?
                ambassadors_[_customerAddress] == true &&
                
                // does the customer purchase exceed the max ambassador quota?
                (ambassadorAccumulatedQuota_[_customerAddress] + _amountOfEthereum) <= ambassadorMaxPurchase_
                
            );
            
            // updated the accumulated quota    
            ambassadorAccumulatedQuota_[_customerAddress] = SafeMath.add(ambassadorAccumulatedQuota_[_customerAddress], _amountOfEthereum);
        
            // execute
            _;
        } else {
            // in case the ether count drops low, the ambassador phase won't reinitiate
            onlyAmbassadors = false;
            _;
        }
        
    }
    
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    // MODIFIERS
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    modifier isHuman() {
        address _addr = msg.sender;
        uint256 _codeLength;
        
        assembly {_codeLength := extcodesize(_addr)}
        require(_codeLength == 0, "sorry humans only");
        require(tx.origin == msg.sender, "sorry humans only");
        _;
    }
    
    /*==============================
    =            EVENTS            =
    ==============================*/

    event onTokenPurchase(
        address indexed customerAddress,
        uint256 incomingEthereum,
        uint256 tokensMinted,
        address indexed referredBy
    );
    
    event onTokenSell(
        address indexed customerAddress,
        uint256 tokensBurned,
        uint256 ethereumEarned
    );
    
    event onReinvestment(
        address indexed customerAddress,
        uint256 ethereumReinvested,
        uint256 tokensMinted
    );
    
    event onWithdraw(
        address indexed customerAddress,
        uint256 ethereumWithdrawn
    );
    
    event onShareDividend(
        address indexed customerAddress,
        uint256 time,
        uint256 amount,
        uint256 currentProfitPerShare,
        uint256 profitPerShare
    );
    
    event onSetName(
        address indexed customerAddress,
        string name
    );
    
    // ERC20
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 tokens
    );
    
    /*=====================================
    =            CONFIGURABLES            =
    =====================================*/

    string public symbol = "LAMB7";
    string public name = "Lambda";
    string public memo = "Lambda是区块链基础设施存储项目，Lambda向去中心化应用提供可无限扩展的数据存储能力。Lambda是中国的FileCoin";
    uint256 public tag = now; // The only label can be used as the intelligent contracts Version available or number
    uint256 public PurchaseLimit = 50000000000000000000000; // 50000 pic
    uint256 public shareDiviesLowerLimit = 0.02 ether; // The minimum amount of share out bonus
    address public isEmptyAddress = 0x0000000000000000000000000000000000000000;
    uint8 constant public decimals = 18;
    
    // Divisor cannot be equal to zero
    // Trading rebate to calculate the ratio is greater than the referral bonuses
    // Recommended in rebate reward should be included in the deal
    // Referral bonuses must be smaller than the rebate
    // The percentage is equal to the algorithm 100 / fee_
    // (100/value) value The scope of 50-10 [50=2%, 25=4%, 20=5%, 16=6.25%,12=8.3%,11=9%,10=10%]
    uint8 public dividendFee_ = 10; // Proportion is equal to the SafeMath.div（amount, dividendFee_)
    // (100/value) value The scope of 10-2 [10=10%, 6=16%, 5=20%, 4=25%, 3=33%,2=50%]
    uint8 public referrerFee_ = 2; // Proportion is equal to the SafeMath.div（amount, dividendFee_）
    
    uint256 constant internal tokenPriceInitial_ = 0.0000001 ether;
    uint256 constant internal tokenPriceIncremental_ = 0.00000001 ether;
    uint256 constant internal magnitude = 2**64;
   
    // proof of stake (defaults at 100 tokens)
    uint256 public stakingRequirement = 100e18;
    
    // ambassador program
    mapping(address => bool) public ambassadors_;
    uint256 public ambassadorMaxPurchase_ = 1 ether; // Shareholders purchase
    uint256 public ambassadorQuota_ = 20 ether; // The total amount of shareholder is restricted
    
    
   /*=================================
    =            DATASETS            =
    ================================*/
    // amount of shares for each address (scaled number)
    mapping(address => uint256) public tokenBalanceLedger_;
    mapping(address => uint256) public referralBalance_;
    mapping(address => int256) public payoutsTo_;
    mapping(address => uint256) public ambassadorAccumulatedQuota_;
    uint256 internal tokenSupply_ = 0;
    uint256 internal profitPerShare_;
    
    // administrator list (see above on what they can do)
    mapping(bytes32 => bool) public administrators;
    
    // affirmant For the third party confirmation (example, modify purchase value limit)
    mapping(bytes32 => bool) public EXadministrators;

    // when this is set to true, only ambassadors can purchase tokens (this prevents a whale premine, it ensures a fairly distributed upper pyramid)
    bool public onlyAmbassadors = true;
    
    tradeData.dividendRecord[] public dividendRecordList;
    tradeData.confirmeParam public bothConfirmeParam;

    /*=======================================
    =            PUBLIC FUNCTIONS            =
    =======================================*/
    /*
    * -- APPLICATION ENTRY POINTS --  
    */
    constructor() public{
        
        // add EXadministrators here [RC2 58f]
        EXadministrators[0x0572d582a3bc9ae3c51d0e86989d7fa29b75555fbb36ce5a6700c46e4c3598d1] = true;

        // add administrators here [RC1 458]
        administrators[0x7818cf405bdd8da4725cdfc3d83990bd9ae128b2a26c8d647e80b57afcdf8596] = true;

        // add the ambassadors here.
        // mantso - lead solidity dev & lead web dev. 
        ambassadors_[0x04B3af156A56a497426047Ecf5F4bAE3f534d58F] = true;
        
        // ponzibot - mathematics & website, and undisputed meme god.
        ambassadors_[0x0f458ab745168191efC917F6E1dbdFD698A232B4] = true;
        
        // swagg - concept design, feedback, management.
        ambassadors_[0xAfF77E4b4980beFbC7D297544E5D945e70FF73e5] = true;
        
        // k-dawgz - shilling machine, meme maestro, bizman.
        ambassadors_[0xe190c28bb3965C7013A523848181175228055e8f] = true;
        
        // elmojo - all those pretty .GIFs & memes you see? you can thank this man for that.
        ambassadors_[0x76637b31163b438b15BBf61Bcf878495F7A0Ea4f] = true;
        
        // capex - community moderator.
        ambassadors_[0x2d6283FF3777Ae609B01b4BB9dA1e95088204400] = true;
        
        // j?rmungandr - pentests & twitter trendsetter.
        ambassadors_[0x36cA5db7bd28ad839a9BD2Ab79dF6F67bF7DfB2F] = true;
        
        // inventor - the source behind the non-intrusive referral model.
        ambassadors_[0xCf52875fda3ad1994886651Dd4D8ADc2938bB245] = true;
        
        // tocsick - pentesting, contract auditing.
        ambassadors_[0xBF9A45f956F459D470235f4B25f6C44d9f501ad3] = true;
        
        // arc - pentesting, contract auditing.
        ambassadors_[0x026283a2a9e0cd723425645F1cE18168d02DDD01] = true;
        
        // sumpunk - contract auditing.
        ambassadors_[0xdcC5D774a54733981E94C245172F7E2Cd8749771] = true;
        
        // randall - charts & sheets, data dissector, advisor.
        ambassadors_[0x5025fDB82e3813B2077a944FEaA166553eCe9302] = true;
        
        // ambius - 3d chart visualization.
        ambassadors_[0x88438a476AdE52368E518A741EC13ED27E8C14f6] = true;
        
        // contributors that need to remain private out of security concerns.
        ambassadors_[0x4E2fe8671f799bEdf62D526Ce23be9389d9D8438] = true; //dp
        ambassadors_[0x569afbB4AA0ED54C1E1b4a1958f0FBc0eBf60bb1] = true; //tc
        ambassadors_[0xF74493fa653AC573da925E50388eb6368aC41A9E] = true; //ja
        ambassadors_[0xFF6fa8D19b9534104c0F4F81C82dFb0f30c1Cb3c] = true; //sf
        ambassadors_[0x1f187B81fB7b0168a0261380c93C4C370F5ABb06] = true; //tb
        ambassadors_[0x2B2f84E55b21a743Ed1d37f0F574eF817663d362] = true; //sm
        ambassadors_[0x706e17Ab71f84C704945Bd272f3B34FC8b32cE09] = true; //mc
        ambassadors_[0x9b55B24Ae2f16CD509D1e57a89EB8985CA249Cb0] = true; //et
        ambassadors_[0x1151A85fA688cf21949a277242A610f4d8d1fAD0] = true; //sn
        ambassadors_[0xe65d09a935aC95377ECa215a3Fc7827bCD69b5cb] = true; //bt
        ambassadors_[0xBe1bB799f587249ad8bEf492Cc48E0D5bBB2c991] = true; //al

    }
    
     
    /**
     * Converts all incoming ethereum to tokens for the caller, and passes down the referral addy (if any)
     */
    function buy(address _referredBy)
        public
        payable
        returns(uint256)
    {
        purchaseTokens(msg.value, _referredBy);
    }
    
    /**
     * Fallback function to handle ethereum that was send straight to the contract
     * Unfortunately we cannot use a referral address this way.
     */
    function()
        payable
        external
    {
        purchaseTokens(msg.value, isEmptyAddress);
    }
    
    /**
     * Converts all of caller's dividends to tokens.
     */
    function reinvest()
        TokenSupplyLessLimit()
        onlyStronghands()
        public
    {
        // fetch dividends
        uint256 _dividends = myDividends(false); // retrieve ref. bonus later in the code
        
        // pay out the dividends virtually
        address _customerAddress = msg.sender;
        payoutsTo_[_customerAddress] +=  (int256) (_dividends * magnitude);
        
        // retrieve ref. bonus
        _dividends += referralBalance_[_customerAddress];
        referralBalance_[_customerAddress] = 0;
        
        // dispatch a buy order with the virtualized "withdrawn dividends"
        uint256 _tokens = purchaseTokens(_dividends, isEmptyAddress);
        
        // fire event
        emit onReinvestment(_customerAddress, _dividends, _tokens);
    }
    
    /**
     * Alias of sell() and withdraw().
     */
    function exit()
        public
    {
        // get token count for caller & sell them all
        address _customerAddress = msg.sender;
        uint256 _tokens = tokenBalanceLedger_[_customerAddress];
        if(_tokens > 0) sell(_tokens);
        
        // lambo delivery service
        withdraw();
    }

    /**
     * Withdraws all of the callers earnings.
     */
    function withdraw()
        onlyStronghands()
        public
    {
        // setup data
        address payable _customerAddress = msg.sender;
        uint256 _dividends = myDividends(false); // get ref. bonus later in the code
        
        // update dividend tracker
        payoutsTo_[_customerAddress] +=  (int256) (_dividends * magnitude);
        
        // add ref. bonus
        _dividends += referralBalance_[_customerAddress];
        referralBalance_[_customerAddress] = 0;
        
        // lambo delivery service
        _customerAddress.transfer(_dividends);
        
        // fire event
        emit onWithdraw(_customerAddress, _dividends);
    }
    
    /**
     * Liquifies tokens to ethereum.
     */
    function sell(uint256 _amountOfTokens)
        isHuman()
        onlyBagholders()
        public
    {
        // setup data
        address _customerAddress = msg.sender;
        // russian hackers BTFO
        require(_amountOfTokens <= tokenBalanceLedger_[_customerAddress]);
        uint256 _tokens = _amountOfTokens;
        uint256 _ethereum = tokensToEthereum_(_tokens);
        uint256 _dividends = SafeMath.div(_ethereum, dividendFee_);
        uint256 _taxedEthereum = SafeMath.sub(_ethereum, _dividends);
        
        // burn the sold tokens
        tokenSupply_ = SafeMath.sub(tokenSupply_, _tokens);
        tokenBalanceLedger_[_customerAddress] = SafeMath.sub(tokenBalanceLedger_[_customerAddress], _tokens);
        
        // update dividends tracker
        int256 _updatedPayouts = (int256) (profitPerShare_ * _tokens + (_taxedEthereum * magnitude));
        payoutsTo_[_customerAddress] -= _updatedPayouts;       
        
        // dividing by zero is a bad idea
        if (tokenSupply_ > 0) {
            // update the amount of dividends per token
            profitPerShare_ = SafeMath.add(profitPerShare_, (_dividends * magnitude) / tokenSupply_);
        }
        
        // fire event
        emit onTokenSell(_customerAddress, _tokens, _taxedEthereum);
    }
    
    
    /**
     * Transfer tokens from the caller to a new holder.
     * Remember, there's a 10% fee here as well.
     */
    function transfer(address _toAddress, uint256 _amountOfTokens)
        onlyBagholders()
        public
        returns(bool)
    {
        // setup
        address _customerAddress = msg.sender;
        
        // make sure we have the requested tokens
        // also disables transfers until ambassador phase is over
        // ( we dont want whale premines )
        require(!onlyAmbassadors && _amountOfTokens <= tokenBalanceLedger_[_customerAddress]);
        
        // withdraw all outstanding dividends first
        if(myDividends(true) > 0) withdraw();
        
        // liquify 10% of the tokens that are transfered
        // these are dispersed to shareholders
        uint256 _tokenFee = SafeMath.div(_amountOfTokens, dividendFee_);
        uint256 _taxedTokens = SafeMath.sub(_amountOfTokens, _tokenFee);
        uint256 _dividends = tokensToEthereum_(_tokenFee);
  
        // burn the fee tokens
        tokenSupply_ = SafeMath.sub(tokenSupply_, _tokenFee);

        // exchange tokens
        tokenBalanceLedger_[_customerAddress] = SafeMath.sub(tokenBalanceLedger_[_customerAddress], _amountOfTokens);
        tokenBalanceLedger_[_toAddress] = SafeMath.add(tokenBalanceLedger_[_toAddress], _taxedTokens);
        
        // update dividend trackers
        payoutsTo_[_customerAddress] -= (int256) (profitPerShare_ * _amountOfTokens);
        payoutsTo_[_toAddress] += (int256) (profitPerShare_ * _taxedTokens);
        
        // disperse dividends among holders
        profitPerShare_ = SafeMath.add(profitPerShare_, (_dividends * magnitude) / tokenSupply_);
        
        // fire event
        emit Transfer(_customerAddress, _toAddress, _taxedTokens);
        
        // ERC20
        return true;
       
    }
    
    /*----------  ADMINISTRATOR ONLY FUNCTIONS  ----------*/
    /**
     * In case the amassador quota is not met, the administrator can manually disable the ambassador phase.
     */
    function disableInitialStage()
        onlyAdministrator()
        public
    {
        onlyAmbassadors = false;
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
    
    /**
     * reset EXAdministrator 
     */
    function setEXAdministrator(bytes32 _identifier, bool _status)
        onlyEXAdministrator()
        public
    {
        EXadministrators[_identifier] = _status;
    }
    
    /**
     * Precautionary measures in case we need to adjust the masternode rate.
     */
    function setStakingRequirement(uint256 _amountOfTokens)
        onlyAdministrator()
        public
    {
        stakingRequirement = _amountOfTokens;
    }
    
    /*----------  HELPERS AND CALCULATORS  ----------*/
    /**
     * Method to view the current Ethereum stored in the contract
     * Example: totalEthereumBalance()
     */
    function totalEthereumBalance()
        public
        view
        returns(uint)
    {
        return address(this).balance;
    }
    
    /**
     * Retrieve the total token supply.
     */
    function totalSupply()
        public
        view
        returns(uint256)
    {
        return tokenSupply_;
    }
    
    /**
     * Retrieve the tokens owned by the caller.
     */
    function myTokens()
        public
        view
        returns(uint256)
    {
        address _customerAddress = msg.sender;
        return balanceOf(_customerAddress);
    }
    
    /**
     * Retrieve the dividends owned by the caller.
     * If `_includeReferralBonus` is to to 1/true, the referral bonus will be included in the calculations.
     * The reason for this, is that in the frontend, we will want to get the total divs (global + ref)
     * But in the internal calculations, we want them separate. 
     */ 
    function myDividends(bool _includeReferralBonus) 
        public 
        view 
        returns(uint256)
    {
        address _customerAddress = msg.sender;
        return _includeReferralBonus ? dividendsOf(_customerAddress) + referralBalance_[_customerAddress] : dividendsOf(_customerAddress) ;
    }
    
    /**
     * Retrieve the token balance of any single address.
     */
    function balanceOf(address _customerAddress)
        view
        public
        returns(uint256)
    {
        return tokenBalanceLedger_[_customerAddress];
    }
    
    /**
     * Retrieve the dividend balance of any single address.
     */
    function dividendsOf(address _customerAddress)
        view
        public
        returns(uint256)
    {
        return (uint256) ((int256)(profitPerShare_ * tokenBalanceLedger_[_customerAddress]) - payoutsTo_[_customerAddress]) / magnitude;
    }
    
    /**
     * Return the buy price of 1 individual token.
     */
    function sellPrice() 
        public 
        view 
        returns(uint256)
    {
        // our calculation relies on the token supply, so we need supply. Doh.
        if(tokenSupply_ == 0){
            return tokenPriceInitial_ - tokenPriceIncremental_;
        } else {
            uint256 _ethereum = tokensToEthereum_(1e18);
            uint256 _dividends = SafeMath.div(_ethereum, dividendFee_  );
            uint256 _taxedEthereum = SafeMath.sub(_ethereum, _dividends);
            return _taxedEthereum;
        }
    }
    
    /**
     * Return the sell price of 1 individual token.
     */
    function buyPrice() 
        public 
        view 
        returns(uint256)
    {
        // our calculation relies on the token supply, so we need supply. Doh.
        if(tokenSupply_ == 0){
            return tokenPriceInitial_ + tokenPriceIncremental_;
        } else {
            uint256 _ethereum = tokensToEthereum_(1e18);
            uint256 _dividends = SafeMath.div(_ethereum, dividendFee_  );
            uint256 _taxedEthereum = SafeMath.add(_ethereum, _dividends);
            return _taxedEthereum;
        }
    }
    
    /**
     * Function for the frontend to dynamically retrieve the price scaling of buy orders.
     */
    function calculateTokensReceived(uint256 _ethereumToSpend) 
        public 
        view 
        returns(uint256, uint256, uint256)
    {
        uint256 _dividends = SafeMath.div(_ethereumToSpend, dividendFee_);
        uint256 _taxedEthereum = SafeMath.sub(_ethereumToSpend, _dividends);
        uint256 _amountOfTokens = ethereumToTokens_(_taxedEthereum);
        
        return (_amountOfTokens,_dividends,_amountOfTokens);
    }
    
    /**
     * Function for the frontend to dynamically retrieve the price scaling of sell orders.
     */
    function calculateEthereumReceived(uint256 _tokensToSell) 
        public 
        view 
        returns(uint256)
    {
        require(_tokensToSell <= tokenSupply_);
        uint256 _ethereum = tokensToEthereum_(_tokensToSell);
        uint256 _dividends = SafeMath.div(_ethereum, dividendFee_);
        uint256 _taxedEthereum = SafeMath.sub(_ethereum, _dividends);
        return _taxedEthereum;
    }
    
    /*==========================================
    =            INTERNAL FUNCTIONS            =
    ==========================================*/
    function purchaseTokens(uint256 _incomingEthereum, address _referredBy)
        TokenSupplyLessLimit()
        antiEarlyWhale(_incomingEthereum)
        internal
        returns(uint256)
    {
        // data setup
        address _customerAddress = msg.sender;
        uint256 _undividedDividends = SafeMath.div(_incomingEthereum, dividendFee_);
        uint256 _referralBonus = SafeMath.div(_undividedDividends, referrerFee_);
        uint256 _dividends = SafeMath.sub(_undividedDividends, _referralBonus);
        uint256 _taxedEthereum = SafeMath.sub(_incomingEthereum, _undividedDividends);
        uint256 _amountOfTokens = ethereumToTokens_(_taxedEthereum);
        uint256 _fee = _dividends * magnitude;
 
        // no point in continuing execution if OP is a poorfag russian hacker
        // prevents overflow in the case that the pyramid somehow magically starts being used by everyone in the world
        // (or hackers)
        // and yes we know that the safemath function automatically rules out the "greater then" equasion.
        require(_amountOfTokens > 0 && (SafeMath.add(_amountOfTokens,tokenSupply_) > tokenSupply_));
        
        // is the user referred by a masternode?
        if(
            // is this a referred purchase?
            _referredBy != isEmptyAddress &&

            // no cheating!
            _referredBy != _customerAddress &&
            
            // does the referrer have at least X whole tokens?
            // i.e is the referrer a godly chad masternode
            tokenBalanceLedger_[_referredBy] >= stakingRequirement
        ){
            // wealth redistribution
            referralBalance_[_referredBy] = SafeMath.add(referralBalance_[_referredBy], _referralBonus);
        } else {
            // no ref purchase
            // add the referral bonus back to the global dividends cake
            _dividends = SafeMath.add(_dividends, _referralBonus);
            _fee = _dividends * magnitude;
        }
        
        // we can't give people infinite ethereum
        if(tokenSupply_ > 0){
            
            // add tokens to the pool
            tokenSupply_ = SafeMath.add(tokenSupply_, _amountOfTokens);
 
            // take the amount of dividends gained through this transaction, and allocates them evenly to each shareholder
            profitPerShare_ += (_dividends * magnitude / (tokenSupply_));
            
            // calculate the amount of tokens the customer receives over his purchase 
            _fee = _fee - (_fee-(_amountOfTokens * (_dividends * magnitude / (tokenSupply_))));
        
        } else {
            // add tokens to the pool
            tokenSupply_ = _amountOfTokens;
        }
        
        // update circulating supply & the ledger address for the customer
        tokenBalanceLedger_[_customerAddress] = SafeMath.add(tokenBalanceLedger_[_customerAddress], _amountOfTokens);
        
        // Tells the contract that the buyer doesn't deserve dividends for the tokens before they owned them;
        //really i know you think you do but you don't
        int256 _updatedPayouts = (int256) ((profitPerShare_ * _amountOfTokens) - _fee);
        payoutsTo_[_customerAddress] += _updatedPayouts;
        
        // fire event
        emit onTokenPurchase(_customerAddress, _incomingEthereum, _amountOfTokens, _referredBy);
        
        return _amountOfTokens;
    }

    /**
     * Calculate Token price based on an amount of incoming ethereum
     * It's an algorithm, hopefully we gave you the whitepaper with it in scientific notation;
     * Some conversions occurred to prevent decimal errors or underflows / overflows in solidity code.
     */
    function ethereumToTokens_(uint256 _ethereum)
        internal
        view
        returns(uint256)
    {
        uint256 _tokenPriceInitial = tokenPriceInitial_ * 1e18;
        uint256 _tokensReceived = 
         (
            (
                // underflow attempts BTFO
                SafeMath.sub(
                    (sqrt
                        (
                            (_tokenPriceInitial**2)
                            +
                            (2*(tokenPriceIncremental_ * 1e18)*(_ethereum * 1e18))
                            +
                            (((tokenPriceIncremental_)**2)*(tokenSupply_**2))
                            +
                            (2*(tokenPriceIncremental_)*_tokenPriceInitial*tokenSupply_)
                        )
                    ), _tokenPriceInitial
                )
            )/(tokenPriceIncremental_)
        )-(tokenSupply_)
        ;
  
        return _tokensReceived;
    }
    
    /**
     * Calculate token sell value.
     * It's an algorithm, hopefully we gave you the whitepaper with it in scientific notation;
     * Some conversions occurred to prevent decimal errors or underflows / overflows in solidity code.
     */
     function tokensToEthereum_(uint256 _tokens)
        internal
        view
        returns(uint256)
    {

        uint256 tokens_ = (_tokens + 1e18);
        uint256 _tokenSupply = (tokenSupply_ + 1e18);
        uint256 _etherReceived =
        (
            // underflow attempts BTFO
            SafeMath.sub(
                (
                    (
                        (
                            tokenPriceInitial_ +(tokenPriceIncremental_ * (_tokenSupply/1e18))
                        )-tokenPriceIncremental_
                    )*(tokens_ - 1e18)
                ),(tokenPriceIncremental_*((tokens_**2-tokens_)/1e18))/2
            )
        /1e18);
        return _etherReceived;
    }
    
    
    //This is where all your gas goes, sorry
    //Not sorry, you probably only paid 1 gwei
    function sqrt(uint x) internal pure returns (uint y) {
        uint z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }
}


/** title -tradeEx- v1100
 * 
 *    __              .___     _______________  ___
 *  _/  |______     __| _/____ \_   _____/\   \/  /
 *  \   __\__  \   / __ |/ __ \ |    __)_  \     / 
 *  |  |  / __ \_/ /_/ \  ___/ |        \ /     \ 
 *  |__| (____  /\____ |\___  >_______  //___/\  \
 *          \/      \/    \/        \/       \_/
 *
 * 
 * Extension contract
 * Fill allow the owner contracts and add the dividends's function
 * 
*/

contract tradeEx is trade{
    
    // String comparison
    function stringsEqual(string memory _a, string memory _b)pure internal returns (bool) {
		bytes memory a = bytes(_a);
		bytes memory b = bytes(_b);
		if (a.length != b.length)
			return false;
		// @todo unroll this loop
		for (uint i = 0; i < a.length; i ++)
			if (a[i] != b[i])
				return false;
		return true;
	}
	
   /**
   * get the token base info
   */
    function getMetadata()
    public
    view
    returns (string memory,string memory,string memory,uint256,uint256,uint8, uint8,uint256,uint256,bool){
        return (name,
               symbol,
               memo,
               tag,
               PurchaseLimit,
               dividendFee_,
               referrerFee_,
               ambassadorMaxPurchase_,
               ambassadorQuota_,
               onlyAmbassadors);
    }
    
   /**
   * Reset the dividend threshold The default is 10 eth
   */
    function setShareDiviesLowerLimit(uint256 pm)
    onlyAdministrator()
    public
    returns(uint256) {
        shareDiviesLowerLimit = pm;
        return shareDiviesLowerLimit;
    }

    /**
     * In case one of us dies, we need to replace ourselves.
     */
    function setAmbassadors(address _ambassadors, bool _status)
    onlyAdministrator()
    public
    {
        ambassadors_[_ambassadors] = _status;
    }
    
    function setAmbassadorMaxPurchase(uint256 pm)
    onlyAdministrator()
    public {
        ambassadorMaxPurchase_ = pm;
    }
    
    function setAmbassadorQuota(uint256 pm)
    onlyAdministrator()
    public {
        ambassadorQuota_ = pm;
    }
    
     /**
     * If we want to rebrand, we can.
     */
    function submitResetName(string memory _name)
    onlyAdministrator()
    public
    {
        bothConfirmeParam.name = _name;
    }
    
    function confirmResetName(string memory _name)
    onlyEXAdministrator()
    public {
                
        require (stringsEqual(bothConfirmeParam.name, _name) == true);
     
        name = bothConfirmeParam.name;
        
        emit onSetName(msg.sender, name);
    }
    
    /**
     * If we want to rebrand, we can.
     */
    function submitResetSymbol(string memory _symbol)
        onlyAdministrator()
        public
    {
        bothConfirmeParam.symbol = _symbol;
    }
    
    function confirmResetSymbol(string memory _symbol)
    onlyEXAdministrator()
    public {
        
        require (stringsEqual(bothConfirmeParam.symbol, _symbol) == true);
        
        symbol = bothConfirmeParam.symbol;
        
    }
    
    function submitResetMemo(string memory _memo)
        onlyAdministrator()
        public
    {
        bothConfirmeParam.memo = _memo;
    }
    
    function confirmResetMemo(string memory _memo)
    onlyEXAdministrator()
    public {
        
        require (stringsEqual(bothConfirmeParam.memo, _memo) == true);

        memo = bothConfirmeParam.memo;
        
    }
   
    /**
    * By the project to submit an application to modify purchase limit
    * In the confirmed official revision purchase limit
    */
    function submitResetPurchaseLimit(uint256 pm)
    onlyAdministrator()
    public
    returns (uint256){
        
        require (pm > tokenSupply_);
        bothConfirmeParam.PurchaseLimit = pm;
        return (bothConfirmeParam.PurchaseLimit);
    }
    
    
    /**
    * By the project to submit an application to modify purchase limit
    * In the confirmed official[exchange] revision purchase limit
    */
    function confirmResetPurchaseLimit(uint256 pm)
    onlyEXAdministrator()
    public
    returns (uint256) {
        
        require (pm > tokenSupply_);
        require (pm == bothConfirmeParam.PurchaseLimit);
        PurchaseLimit += bothConfirmeParam.PurchaseLimit;
        
        return PurchaseLimit;
    }
        
    function submitResetDividendFee(uint8 _pm)
    onlyAdministrator()
    public
    {
        require (_pm > 1);
        bothConfirmeParam.dividendFee = _pm;
    }
    
    function confirmResetDividendFee(uint8 _pm)
    onlyEXAdministrator()
    public {
        
        require (bothConfirmeParam.dividendFee == _pm);
        dividendFee_ = bothConfirmeParam.dividendFee;
        
    }
    
    function submitResetReferrerFee(uint8 _pm)
    onlyAdministrator()
    public
    {
        require (dividendFee_ > _pm);
        bothConfirmeParam.referrerFee = _pm;
    }
    
    function confirmResetReferrerFee(uint8 _pm)
    onlyEXAdministrator()
    public {
        
        require (bothConfirmeParam.referrerFee == _pm);
        referrerFee_ = bothConfirmeParam.referrerFee;
        
    }
    
    function getBothConfirmeParam() 
    public
    view
    returns (string memory,string memory,string memory,uint256, uint8, uint8){
      return (
          bothConfirmeParam.name,
          bothConfirmeParam.symbol,
          bothConfirmeParam.memo,
          bothConfirmeParam.PurchaseLimit,
          bothConfirmeParam.dividendFee,
          bothConfirmeParam.referrerFee
          );
    }
    
    /**
    * Confirm the current account is the administrator
    */
    function getIsAdministartor()public view returns(bool){
        address _customerAddress = msg.sender;
        bool res = administrators[keccak256(abi.encodePacked(_customerAddress))];
        return res;
    }
    
    /**
    * Receive dividends and add the dividends
    * The only increase the bonus pool
    * The embodiment of the rights and interests of every dollar bonuses in account
    */    
    function shareDivies()
    bagTokenSupply()
    public 
    payable 
    returns(uint256) {
        
        require(msg.value >= shareDiviesLowerLimit, "Need is greater than the minimum value of share out bonus");
        
        uint256 amount = msg.value;
        uint256 now_ = now;
        address address_ = msg.sender;
        
        uint256 perShare = amount / tokenSupply_;

        uint256 currentProfitPerShare = (amount * magnitude) / tokenSupply_;
        // update the amount of dividends per token
        profitPerShare_ = SafeMath.add(profitPerShare_, currentProfitPerShare);
                
        tradeData.dividendRecord memory dividendRecord_;
        dividendRecord_.time = now_;
        dividendRecord_.addr = address_;
        dividendRecord_.amount = amount;
        dividendRecord_.tokenSupply = tokenSupply_;
        dividendRecord_.profitPerShare = perShare;
        dividendRecordList.push(dividendRecord_);

        emit onShareDividend(address_, now_, amount, perShare, profitPerShare_);
        
        return perShare;
        
    }
    
    
    /**
    * For the length of the record of share out bonus
    * Used in front end loop gain bonus record
    */
    function dividendRecordListLength() public view returns(uint256) {
        return (dividendRecordList.length);
    }
    
    /**
    * Access to records of share out bonus
    */
    function getShareDiviesRecord(uint256 index_) 
    public 
    view 
    returns (uint256, address, uint256, uint256, uint256) {
        
        require(index_ <= dividendRecordListLength(), "Beyond the scope of record");
        
        return(
            dividendRecordList[index_].time,
            dividendRecordList[index_].addr,
            dividendRecordList[index_].amount,
            dividendRecordList[index_].tokenSupply,
            dividendRecordList[index_].profitPerShare
            );
    }
  
    /**
    * The current distribution of bonus pool size
    */  
    function getProfitPerShare() public view returns (uint256) {
        return profitPerShare_;
    }
    
    /**
    *
    * Cash accounts for the total percentage for current account
    */
    function tokensScaleOf(address addr) public view returns (uint256) {
        
        uint256 balance_ = balanceOf(addr);
        
        return SafeMath.div(balance_, tokenSupply_);
    }
    
    // Tax test use test dividendFee_ ,referrerFee_ ...
    function taxTest(uint256 _inputEth, address _refby) 
    TokenSupplyLessLimit()
    public
    view
    returns (uint256,uint256,uint256,uint256,uint256,uint256,bool)
    {
        uint256 _undividedDividends = SafeMath.div(_inputEth, dividendFee_);
        uint256 _referralBonus = SafeMath.div(_undividedDividends, referrerFee_);
        uint256 _dividends = SafeMath.sub(_undividedDividends, _referralBonus);
        uint256 _taxedEthereum = SafeMath.sub(_inputEth, _undividedDividends);
        uint256 _amountOfTokens = ethereumToTokens_(_taxedEthereum);
        uint256 _fee = _dividends * magnitude;
        bool _byisEmpty = true;
        if(_refby != isEmptyAddress) {
            _byisEmpty = false;
        }
        
        return (_undividedDividends,_referralBonus,_dividends,_taxedEthereum,_amountOfTokens,_fee, _byisEmpty);
    }
    
}


/**
*
* Extend the database
* Data structure classes to add here
* 
*/
library tradeData {
    
    /**
    * Keep records of share out bonus
    * Anyone can share out bonus
    */
    struct dividendRecord {
        uint256 time;
        address addr;
        uint256 amount;
        uint256 tokenSupply;
        uint256 profitPerShare;
    }
    
    /**
    * Need can modify the parameters of the two sides confirmed
    */
    struct confirmeParam {
        string name;
        string symbol;
        string memo;
        uint256 PurchaseLimit;
        uint8 dividendFee;
        uint8 referrerFee;
    }

}


/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
    
    /** x
    * @dev Multiplies two numbers, throws on overflow.
    */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    /** /
    * @dev Integer division of two numbers, truncating the quotient.
    */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    /** -
    * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
    */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    /** +
    * @dev Adds two numbers, throws on overflow.
    */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
    
}