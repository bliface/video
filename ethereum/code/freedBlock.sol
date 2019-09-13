pragma solidity ^0.4.20;

contract FreeRegion {
    
    //本期中奖号池（例第二期 押大方胜）
    // scheduleAmount 本期总金额
    // winOn 赢的一方
    // winAmount 赢方总金额，用于计算赢方投注金额在赢方总金额中所占比例以此分配本期总金额
    struct scheduleSet{
        uint schedule;
        bool action;
        uint scheduleAmount;
        uint WinOn;
        uint winAmount;
        uint startTime;
        uint endTime;
    }
    
    //用户投注列表
    struct betSet{
        address id;
        uint schedule;
        uint betOn;
        uint amount;
        uint petTime;
        uint winAmount;
        bool isget;
    }
    
    //可投注方列表（候选方 例如大或小）
    struct candidate{
        uint id;
        string des;
    }
    
    uint intervalTime=120;//intervalTime每期的间隔时间（单位秒）
    uint betAmount;
    uint webNow;
    candidate[] candidateList;
    scheduleSet[] scheduleSets;
    betSet[] betSets;
    
    event event_OutputNow(uint _pm1,uint _pm2);
    event event_test(uint _pm1,uint _pm2);
    event event_test2(string _pm1,string _pm2);
    
    constructor() public{
        
        candidate memory _candidateA=candidate({
           id:10001,
           des:"小"
        });
        
        candidate memory _candidateB=candidate({
           id:10002,
           des:"大"
        });
        candidateList.push(_candidateA);
        
        candidateList.push(_candidateB);
        
        uint _currNow=now;
        scheduleSet memory _scheduleSet = scheduleSet({
           schedule:1,
           action:true,
           scheduleAmount:0,
           WinOn:0,
           winAmount:0,
           startTime:_currNow,
           endTime:_currNow+intervalTime
       });
       
       scheduleSets.push(_scheduleSet);
        
    }
    
    function createCandidate(uint _id,string _des) public{
        candidate memory _candidate=candidate({
           id:_id,
           des:_des
        });
        
        candidateList.push(_candidate);
    }
    
    // 随机产生期号
    // 开始时间
    // 结束时间
    // 返回新期号
    function createSchedule() public returns(uint) {
       uint _initNumber=0;
       uint _currNow=now;
       if(scheduleSets.length>0){
           _initNumber=scheduleSets[scheduleSets.length-1].schedule+1;
       }
        
       scheduleSet memory _scheduleSet = scheduleSet({
           schedule:_initNumber,
           action:true,
           scheduleAmount:0,
           WinOn:0,
           winAmount:0,
           startTime:_currNow,
           endTime:_currNow+intervalTime
       });
       
       scheduleSets.push(_scheduleSet);
       betAmount=0;// 新一期开始接受投注,上期投注额清零
       
       return _initNumber;
       
    }
    
    function getNow() public view returns(uint){
        return now;
    }
    
    function setNow(uint _now) public returns(uint){
        webNow=_now;
        return webNow;
    }
    
    //随机产生中奖号
    function createScheduleWinner(uint _schedule,uint _WinOn) public returns(uint,uint){
       
        require(scheduleSets.length>0);
        
        uint i=scheduleSets.length-1;
        
        //从后往前搜以提高效率
        while(i>=0){
            if(scheduleSets[i].schedule==_schedule){
                scheduleSets[i].action=false; //在投注结束后产生当期排号以确保公正性
                scheduleSets[i].WinOn=_WinOn;
                dispatch(scheduleSets[i].schedule,scheduleSets[i].WinOn); // 结算本期赢家
                createSchedule(); // 开始新一期
                break;
            }
            
            i--;
        }
       return (scheduleSets[i].schedule,i);
    }
    
        //随机产生中奖号
    function createScheduleWinner2() public view returns(uint,uint,uint){
       
        //require(scheduleSets.length>0);
        
        uint i=scheduleSets.length;
        //uint _schedule= scheduleSets[0].schedule;
        uint re=10;
        while(i>0){
            if(re==9){
                break;
            }
            else{
            re--;
            i--;
            }
        }

       return (scheduleSets.length,re,i);
    }
    
    //新增用户投注
    function createBet(address _person,uint _schedule,uint _betOn,uint _amount,uint _time) public{
        
        bool _action=false;
        (_action,)=getSchedule(_schedule);
        require(_action==true);

        betSet memory _bet=betSet({
           id:_person,
           schedule:_schedule,
           betOn:_betOn,
           amount:_amount,
           petTime:_time,
           winAmount:0,
           isget:false
        });
        
        betSets.push(_bet);
        betAmount=betAmount+_amount;
    }
    
    //派发
    function dispatch(uint _schedule,uint _WinOn) internal{
      
      //计算赢家金额
      uint _winAmount=0;
      for(uint i=0;i<betSets.length;i++){
          
          if(betSets[i].schedule==_schedule && betSets[i].betOn==_WinOn){
              _winAmount=_winAmount+betSets[i].amount;
          }
      }
      
      // 写入本期赢家金额
        uint i2=0;
        while(i2<scheduleSets.length){
            if(scheduleSets[i2].schedule==_schedule){
                scheduleSets[i2].winAmount=_winAmount;
                break;
            }
            i2++;
        }
      
      //按比例将本期总金额分配给所有赢家
      for(uint i3=0;i3<betSets.length;i3++){
          
          if(betSets[i3].schedule==_schedule && betSets[i3].betOn==_WinOn){
              betSets[i3].winAmount =(betSets[i3].amount / _winAmount) * betAmount;
          }
      }
    }
    
    function outputNow(uint _schedule,uint _now) public {
        emit event_OutputNow(_schedule,_now);
    }
    
    function execEventTest() public{
        emit event_test(34,33444);
    }
    
    function execEventTest2(string _pm1,string _pm2) public{
        emit event_test2(_pm1,_pm2);
    }
    
    //本期投注时间结束，则进行清算然后开始新一期投注
    function getTime() public view returns(uint,uint){
        uint _time=now;
        uint _endId=scheduleSets.length-1;
        uint _schedule=0;
        uint _now=0;
        
        if(_time >= scheduleSets[_endId].endTime && scheduleSets[_endId].action==true){
            
            _schedule=scheduleSets[_endId].schedule;
            _now=now;
            
            //emit event_OutputNow(_schedule,_now);
            //return(scheduleSets[_endId].schedule,now);
            //createScheduleWinner(scheduleSets[_endId].schedule);
            //_newSchedule=createSchedule();
        }
        
        return (_schedule,_now);
    }
    
    //返回当期属性
    function getSchedule(uint _schedule) public view returns(bool,uint){
        require(scheduleSets.length>0);
        
        bool _action;
        uint _WinOn;
        
        uint i=0;
        
        while(i<scheduleSets.length){
            if(scheduleSets[i].schedule==_schedule){
                _action=scheduleSets[i].action;
                _WinOn=scheduleSets[i].WinOn;
                break;
            }
            
            i++;
        }
        
        return (_action,_WinOn);
    }
    
    function getBetByIndex(uint x) public view returns(address,uint,uint,uint,uint,bool){
        return (betSets[x].id,betSets[x].betOn,betSets[x].amount,betSets[x].petTime,betSets[x].winAmount,betSets[x].isget);
    }
    
    function getScheduleByIndex(uint x) public view returns(uint,bool,uint,uint,uint){
        return (scheduleSets[x].schedule,scheduleSets[x].action,scheduleSets[x].WinOn,scheduleSets[x].startTime,scheduleSets[x].endTime);
    }
    
    function getCandidate(uint x) public view returns(uint,string){
        return (candidateList[x].id,candidateList[x].des);
    }
    
    function getBetAmount() public view returns(uint){
        return betAmount;
    }
}
