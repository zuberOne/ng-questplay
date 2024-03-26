use core::array::ArrayTrait;
use core::box::BoxTrait;
use core::option::OptionTrait;
use src::sorcerer::Sorcerer;

fn battle(
    ref team1: Array<Sorcerer>, 
    ref team2: Array<Sorcerer>,
    ref finalTeam1: Array<Sorcerer>,
    ref finalTeam2: Array<Sorcerer>

) {

    let mut indexTeam1 = 0;
    let mut indexTeam2 = 0;
            

    
    loop {

    let mut fighter1 = getSorcerer(ref team1, indexTeam1);
    let mut fighter2 = getSorcerer(ref team2, indexTeam2);

    match team1.get(indexTeam1) {
        Option::None => {
            while indexTeam2 < team2.len() {
            finalTeam2.append(getSorcerer(ref team2,indexTeam2));
            indexTeam2 = indexTeam2 + 1;
            };
            let team2 = finalTeam2;
            let team1 = finalTeam1;
            break;
        },
        Option::Some => {
            
        },
    }

        match team2.get(indexTeam2) {
        Option::None => {
            while indexTeam1 < team1.len() {
            finalTeam1.append(getSorcerer(ref team1,indexTeam1));
            indexTeam1 = indexTeam1 + 1;
            };
            let team2 = finalTeam2;
            let team1 = finalTeam1;
            break;
        },
        Option::Some => {
            
        },
    }

    while fighter1.health > 0 && fighter2.health > 0   {
        fight(ref fighter1, ref fighter2);
        fight(ref fighter2, ref fighter1);
        };

        if fighter1.health == 0 {
            indexTeam1 = indexTeam1 +1
        }

        if fighter2.health == 0 {
            indexTeam2 = indexTeam2 +1
        }
    }
    // IMPLEMENT THIS FUNCTION
}


fn fight (ref sorcerer1: Sorcerer, ref sorcerer2: Sorcerer) {
     if (sorcerer1.health <= sorcerer2.attack ) {      
            sorcerer1.health = 0;
        } else {
           sorcerer1.health = sorcerer1.health - sorcerer2.attack;
        }
    
}

fn getSorcerer( ref fromTeam: Array<Sorcerer>, index: u32) -> Sorcerer {
    *fromTeam.get(index).unwrap().unbox()
}