use src::sorcerer::Sorcerer;
use src::sorcerer::Talent;


fn fight (ref sorcerer1: Sorcerer, ref sorcerer2: Sorcerer) {
     if (sorcerer1.health <= sorcerer2.attack ) {      
            sorcerer1.health = 0;
        } else {
           sorcerer1.health = sorcerer1.health - sorcerer2.attack;
        }

}

fn checktalent  (ref sorcerer1: Sorcerer, ref sorcerer2: Sorcerer) {

        match sorcerer1.talent {

            Talent::Talentless  => {
                fight (ref sorcerer1, ref sorcerer2);
            },
            Talent::Venomous => {
                fight (ref sorcerer1, ref sorcerer2);
            },
            Talent::Swift => {
                if (sorcerer2.attack < 4 && sorcerer2.attack != 0  ) {
                sorcerer1.health = sorcerer1.health -1;
            } else {
                fight (ref sorcerer1, ref sorcerer2);
            }
            },
            Talent::Guardian => {
                if sorcerer1.hasBeenDamaged == false {
                    sorcerer1.hasBeenDamaged = true;            
                } else {
                    fight (ref sorcerer1, ref sorcerer2);
                }
            },
}
}

fn checkvenomous  (ref sorcerer1: Sorcerer) {
            match sorcerer1.talent {

            Talent::Talentless  => {
            },
            Talent::Venomous => {
                sorcerer1.attack = sorcerer1.attack + 1;
            },
            Talent::Swift => {
            },
            Talent::Guardian => {
            }
}
}

fn duel(ref sorcerer1: Sorcerer, ref sorcerer2: Sorcerer) {
    // IMPLEMENT THIS FUNCTION

    while sorcerer1.health > 0 && sorcerer2.health > 0   {
  
        checktalent (ref sorcerer1, ref sorcerer2);
        checktalent (ref sorcerer1:sorcerer2, ref sorcerer2:sorcerer1);
        checkvenomous (ref sorcerer1);
        checkvenomous (ref sorcerer2);
    
}
}

