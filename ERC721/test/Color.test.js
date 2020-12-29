const { AssertionError } = require('chai')
const { assert } = require('console')

const Color = artifacts.require("./Color.sol")

require('chai')
.use(require('chai-as-promised'))
.should()

contract('Color', (accounts) => {
let contract

    before(async() => {
        contract = await Color.deployed()
    })

    describe('deployment', async() => {
        it('deploys successfully', async() => {
            const address = contract.address
            console.log(address)

            assert.notEqual(address, 0x0) 
            assert.notEqual(address, null) 
            assert.notEqual(address, undefined) 
            assert.notEqual(address, '') 
        })

        it('has a name', async() => {

            const name = await contract.name()
            assert.equal(name, 'Color')
        })

        it('has a symbol', async() => {

            const symbol = await contract.symbol()
            assert.equal(symbol, 'COLOR')
        })

    })

    describe('minting', async() =>{
        it('creates a new token', async() =>{
            const result = await contract.mint('#FFFFFF')
            const totalSupply = await contract.totalSupply()

            assert.equal(totalSupply,1)
            const event = result.logs[0].args
            assert.equal(event.tokenId.toNumber(), 1, "id is correct")
            assert.equal(event.from, "0x0" , "from is correct")
            assert.equal(event.to, accounts[0], "to is correct")
            //console.log(result)
        })
    })

})
