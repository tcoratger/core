library GenericRouter {
    struct SwapDescription {
        address srcToken;
        address dstToken;
        address payable srcReceiver;
        address payable dstReceiver;
        uint256 amount;
        uint256 minReturnAmount;
        uint256 flags;
    }
}

library OrderLib {
    struct Order {
        uint256 salt;
        address makerAsset;
        address takerAsset;
        address maker;
        address receiver;
        address allowedSender;
        uint256 makingAmount;
        uint256 takingAmount;
        uint256 offsets;
        bytes interactions;
    }
}

library OrderRFQLib {
    struct OrderRFQ {
        uint256 info;
        address makerAsset;
        address takerAsset;
        address maker;
        address allowedSender;
        uint256 makingAmount;
        uint256 takingAmount;
    }
}

interface AggregationRouterV5 {
    error AccessDenied();
    error AdvanceNonceFailed();
    error AlreadyFilled();
    error ArbitraryStaticCallFailed();
    error BadPool();
    error BadSignature();
    error ETHTransferFailed();
    error EmptyPools();
    error EthDepositRejected();
    error GetAmountCallFailed();
    error IncorrectDataLength();
    error InsufficientBalance();
    error InvalidMsgValue();
    error InvalidatedOrder();
    error MakingAmountExceeded();
    error MakingAmountTooLow();
    error OnlyOneAmountShouldBeZero();
    error OrderExpired();
    error PermitLengthTooLow();
    error PredicateIsNotTrue();
    error PrivateOrder();
    error RFQBadSignature();
    error RFQPrivateOrder();
    error RFQSwapWithZeroAmount();
    error RFQZeroTargetIsForbidden();
    error ReentrancyDetected();
    error RemainingAmountIsZero();
    error ReservesCallFailed();
    error ReturnAmountIsNotEnough();
    error SafePermitBadLength();
    error SafeTransferFailed();
    error SafeTransferFromFailed();
    error SimulationResults(bool success, bytes res);
    error SwapAmountTooLarge();
    error SwapWithZeroAmount();
    error TakingAmountExceeded();
    error TakingAmountIncreased();
    error TakingAmountTooHigh();
    error TransferFromMakerToTakerFailed();
    error TransferFromTakerToMakerFailed();
    error UnknownOrder();
    error WrongAmount();
    error WrongGetter();
    error ZeroAddress();
    error ZeroMinReturn();
    error ZeroReturnAmount();
    error ZeroTargetIsForbidden();

    event NonceIncreased(address indexed maker, uint256 newNonce);
    event OrderCanceled(address indexed maker, bytes32 orderHash, uint256 remainingRaw);
    event OrderFilled(address indexed maker, bytes32 orderHash, uint256 remaining);
    event OrderFilledRFQ(bytes32 orderHash, uint256 makingAmount);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    receive() external payable;

    function advanceNonce(uint8 amount) external;
    function and(uint256 offsets, bytes memory data) external view returns (bool);
    function arbitraryStaticCall(address target, bytes memory data) external view returns (uint256);
    function cancelOrder(OrderLib.Order memory order) external returns (uint256 orderRemaining, bytes32 orderHash);
    function cancelOrderRFQ(uint256 orderInfo) external;
    function cancelOrderRFQ(uint256 orderInfo, uint256 additionalMask) external;
    function checkPredicate(OrderLib.Order memory order) external view returns (bool);
    function clipperSwap(address clipperExchange, address srcToken, address dstToken, uint256 inputAmount, uint256 outputAmount, uint256 goodUntil, bytes32 r, bytes32 vs) external payable returns (uint256 returnAmount);
    function clipperSwapTo(address clipperExchange, address payable recipient, address srcToken, address dstToken, uint256 inputAmount, uint256 outputAmount, uint256 goodUntil, bytes32 r, bytes32 vs) external payable returns (uint256 returnAmount);
    function clipperSwapToWithPermit(address clipperExchange, address payable recipient, address srcToken, address dstToken, uint256 inputAmount, uint256 outputAmount, uint256 goodUntil, bytes32 r, bytes32 vs, bytes memory permit) external returns (uint256 returnAmount);
    function destroy() external;
    function eq(uint256 value, bytes memory data) external view returns (bool);
    function fillOrder(OrderLib.Order memory order, bytes memory signature, bytes memory interaction, uint256 makingAmount, uint256 takingAmount, uint256 skipPermitAndThresholdAmount) external payable returns (uint256, uint256, bytes32);
    function fillOrderRFQ(OrderRFQLib.OrderRFQ memory order, bytes memory signature, uint256 flagsAndAmount) external payable returns (uint256, uint256, bytes32);
    function fillOrderRFQCompact(OrderRFQLib.OrderRFQ memory order, bytes32 r, bytes32 vs, uint256 flagsAndAmount) external payable returns (uint256 filledMakingAmount, uint256 filledTakingAmount, bytes32 orderHash);
    function fillOrderRFQTo(OrderRFQLib.OrderRFQ memory order, bytes memory signature, uint256 flagsAndAmount, address target) external payable returns (uint256 filledMakingAmount, uint256 filledTakingAmount, bytes32 orderHash);
    function fillOrderRFQToWithPermit(OrderRFQLib.OrderRFQ memory order, bytes memory signature, uint256 flagsAndAmount, address target, bytes memory permit) external returns (uint256, uint256, bytes32);
    function fillOrderTo(OrderLib.Order memory order_, bytes memory signature, bytes memory interaction, uint256 makingAmount, uint256 takingAmount, uint256 skipPermitAndThresholdAmount, address target) external payable returns (uint256 actualMakingAmount, uint256 actualTakingAmount, bytes32 orderHash);
    function fillOrderToWithPermit(OrderLib.Order memory order, bytes memory signature, bytes memory interaction, uint256 makingAmount, uint256 takingAmount, uint256 skipPermitAndThresholdAmount, address target, bytes memory permit) external returns (uint256, uint256, bytes32);
    function gt(uint256 value, bytes memory data) external view returns (bool);
    function hashOrder(OrderLib.Order memory order) external view returns (bytes32);
    function increaseNonce() external;
    function invalidatorForOrderRFQ(address maker, uint256 slot) external view returns (uint256);
    function lt(uint256 value, bytes memory data) external view returns (bool);
    function nonce(address) external view returns (uint256);
    function nonceEquals(address makerAddress, uint256 makerNonce) external view returns (bool);
    function or(uint256 offsets, bytes memory data) external view returns (bool);
    function owner() external view returns (address);
    function remaining(bytes32 orderHash) external view returns (uint256);
    function remainingRaw(bytes32 orderHash) external view returns (uint256);
    function remainingsRaw(bytes32[] memory orderHashes) external view returns (uint256[] memory);
    function renounceOwnership() external;
    function rescueFunds(address token, uint256 amount) external;
    function simulate(address target, bytes memory data) external;
    function swap(address executor, GenericRouter.SwapDescription memory desc, bytes memory permit, bytes memory data) external payable returns (uint256 returnAmount, uint256 spentAmount);
    function timestampBelow(uint256 time) external view returns (bool);
    function timestampBelowAndNonceEquals(uint256 timeNonceAccount) external view returns (bool);
    function transferOwnership(address newOwner) external;
    function uniswapV3Swap(uint256 amount, uint256 minReturn, uint256[] memory pools) external payable returns (uint256 returnAmount);
    function uniswapV3SwapCallback(int256 amount0Delta, int256 amount1Delta, bytes memory) external;
    function uniswapV3SwapTo(address payable recipient, uint256 amount, uint256 minReturn, uint256[] memory pools) external payable returns (uint256 returnAmount);
    function uniswapV3SwapToWithPermit(address payable recipient, address srcToken, uint256 amount, uint256 minReturn, uint256[] memory pools, bytes memory permit) external returns (uint256 returnAmount);
    function unoswap(address srcToken, uint256 amount, uint256 minReturn, uint256[] memory pools) external payable returns (uint256 returnAmount);
    function unoswapTo(address payable recipient, address srcToken, uint256 amount, uint256 minReturn, uint256[] memory pools) external payable returns (uint256 returnAmount);
    function unoswapToWithPermit(address payable recipient, address srcToken, uint256 amount, uint256 minReturn, uint256[] memory pools, bytes memory permit) external returns (uint256 returnAmount);
}