pragma solidity ^0.5.3;

interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns(uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 indexed value);
}

contract ERC20 is IERC20 {

//name symbol decimal
string public name = "MilkShakes";
string public symbol = "MK";
uint public decimal = 0;

uint private _totalSupply;
mapping (address => uint) public balances;
mapping (address => mapping (address => uint)) public approved;
address public MK_owner;

constructor() public {
    MK_owner = msg.sender;
    _totalSupply = 5000;
    balances[MK_owner] = _totalSupply;
}
    
function totalSupply() external view returns(uint){
    return _totalSupply;
}

function balanceOf(address account) external view returns(uint){
    return balances[account];
}

function transfer(address recipient, uint256 amount) external returns(bool) {
    require(amount <= balances[msg.sender] && amount > 0, "not enough Balance");    
    balances[msg.sender] -= amount;
    balances[recipient] += amount;
    emit Transfer(msg.sender, recipient, amount);
    return true;
}

function approve(address spender, uint256 amount) external returns(bool) {
    require( amount <= balances[msg.sender] && amount > 0, "not enough Balance");
    approved[msg.sender][spender] += amount;
    emit Approval(msg.sender, spender, amount);
    return true;
}

function allowance(address owner, address spender) external view returns(uint){
    return approved[owner][spender];
} 

//Used to spend approved Allowance
function transferFrom(address sender, address recipient, uint256 amount) external returns(bool){
    require( amount <= approved[sender][recipient] && amount > 0 && amount <= balances[sender], "Not enough Balance");
    balances[sender] -= amount;
    approved[sender][msg.sender] -= amount;
    balances[recipient] += amount;
    
    emit Transfer(sender, recipient, amount);
    
    return true;
}

event Transfer (address indexed from, address indexed to, uint256 value);
event Approval (address indexed owner, address indexed spender, uint256 value);
    
}