use core::fmt::{Display, Formatter, Error};

#[derive(Copy, Drop)]
struct Sorcerer {
    attack: u8,
    health: u8,
    talent: Talent,
    hasBeenDamaged: bool,
    isAlive: bool

}

impl SorcererDisplay of Display<Sorcerer> {
    fn fmt(self: @Sorcerer, ref f: Formatter) -> Result<(), Error> {
        let str: ByteArray = format!("Sorcerer ({}, {})", *self.attack, *self.health);
        f.buffer.append(@str);
        Result::Ok(())
    }
}


// For Part 2...
#[derive(Copy, Drop)]
enum Talent {
    Talentless: (),
    Venomous: (),
    Swift: (),
    Guardian: ()
}

#[generate_trait]
impl SorcererImpl of SorcererTrait {

    fn new(attack: u8, health: u8) -> Sorcerer {
        Sorcerer {
            attack: attack,
            health: health,
            talent: Talent::Talentless(()),
            hasBeenDamaged: false,
            isAlive: true
        }
    }

    // For Part 2...
    fn with_talent(attack: u8, health: u8, talent: Talent) -> Sorcerer {
        Sorcerer {
            attack: attack,
            health: health,
            talent: talent,
            hasBeenDamaged: false,
            isAlive: true
        }
    }

    fn attack(self: @Sorcerer) -> u8 { *self.attack }
    fn health(self: @Sorcerer) -> u8 { *self.health }
    fn is_defeated(self: @Sorcerer) -> bool { *self.health == 0_u8 }

}

