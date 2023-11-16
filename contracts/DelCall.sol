// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Logic1 {
    uint256 public value;

    function setValue(uint256 _newValue) external {
        value = _newValue;
    }
}

contract Logic2 {
    uint256 value;

    function setValue(uint256 _newValue) external {
        value += _newValue;
    }
}

contract State {
    uint256 public value;
    address public logicContract;

    constructor(address _receiver) {
        logicContract = _receiver;
    }

    function updateLogicContract(address _logic) external {
        logicContract = _logic;
    }

    function updateValue(uint256 _newValue) external {
        (bool success, ) = logicContract.delegatecall(
            abi.encodeWithSignature("setValue(uint256)", _newValue)
        );
        require(success, "Delegate call failed");
    }
}
