// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

contract testStruct{
    struct pessoas{
        string nome;
        uint idade;
    }
    pessoas[] listaDePss;

    //Adicionando nome e idade (struct pessoas) na lista de pessoas.
    function adcPessoas(string memory _nome, uint _idade) external{
        listaDePss.push(pessoas(_nome, _idade));
    }

    //Retornando a lista de pessoas.
    function obterPessoas() public view returns (pessoas[] memory){
        return listaDePss;

    }

    function obterPessoa(uint _indice) public view returns (string memory _nome, uint _idade){
        pessoas memory p = listaDePss[_indice];
        return (p.nome, p.idade);

    }

    function atualizarPessoas(uint _indice, string memory _nome, uint _idade) external{
        pessoas storage p = listaDePss[_indice];
        p.nome = _nome;
        p.idade = _idade;
        listaDePss[_indice] = p;

    }

    function deletarPessoas(uint _indice) external{
        delete listaDePss[_indice];

    }

    function totalPessoas() external view returns (uint){
       return listaDePss.length;

    }
    /*Criar um laço de repetição (for) que quando o usuario insira o nome 
    da pessoa retorne os dados dela*/

    function acharPessoa(string memory _nome) external view returns (string memory _nomeV, uint _idade) {
     uint _indice = 0;
        for (uint i = 0; i < listaDePss.length; i++ ){
            pessoas memory p = listaDePss[_indice];
            string memory nomeV = p.nome;
            if (keccak256(abi.encodePacked(_nome)) != keccak256(abi.encodePacked(nomeV))){
               _indice ++;
               continue;
               }
               else{
                   return (p.nome, p.idade); 
                   break;
               }
             }
           
    }


}