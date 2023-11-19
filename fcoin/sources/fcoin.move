module fcoin::fcoin {
    use std::option;
    use sui::coin::{Self,Coin,TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self,TxContext};

    struct FCOIN has drop {} 

    fun init(witness: FCOIN, ctx: &mut TxContext){
        let(treasury, metadata) = coin::create_currency(witness,18, b"FCOIN",b"FrogCoin",b"Starttrek Course",option::none(),ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury,tx_context::sender(ctx));
    }
    
    public entry fun mint(
        treasury_cap: &mut TreasuryCap<FCOIN>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx)
    }
   
    public entry fun burn(treasury_cap: &mut TreasuryCap<FCOIN>, coin: Coin<FCOIN>) {
        coin::burn(treasury_cap, coin);
    }
}