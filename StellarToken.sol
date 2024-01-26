// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

// Persona 1 (owner) => 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// Persona 2 (receptor) => 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
// Persona 3 (operador) => 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

contract StellarToken{

    // Declaraciones
    string public name = "Stellar Token";
    string public symbol = "STE";
    uint256 public totalSupply =  10**24;
    uint8 public decimals = 18;

    // Evento para la transferencia de tokens de un usuario
    event Transfer(
        address indexed  _from,
        address indexed _to,
        uint256 _value
    );

    // Evento para la aprobacion de un operador
    event Approval (
        address indexed _owner,
        address indexed  _spender,
        uint256 value
    );

    // Estructura de datos
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    // Constructor
    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    // Transferencia de tokens de un usuario
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value); 
        return true;
    }

    // Aprobacion de una cantidad para ser gastada por un operador
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // Transferencia de tokens especificando el emisor
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from] [msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }



}