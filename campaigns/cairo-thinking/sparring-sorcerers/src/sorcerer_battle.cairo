use core::array::ArrayTrait;
use core::box::BoxTrait;
use core::option::OptionTrait;
use src::sorcerer::Sorcerer;
use src::sorcerer_duel::duel;

fn battle(
    ref team1: Array<Sorcerer>, 
    ref team2: Array<Sorcerer>,

) {

    let mut indexTeam1 = 0;
    let mut indexTeam2 = 0;
    
    let mut sorcerer1 = getSorcerer(ref team1, ref indexTeam1);
    let mut sorcerer2 = getSorcerer(ref team2, ref indexTeam2);


    loop {


        duel(ref sorcerer1, ref sorcerer2);
        
        if sorcerer1.health == 0 {
            indexTeam1 = indexTeam1 + 1;
            if indexTeam1 != team1.len() {
            sorcerer1 = getSorcerer(ref team1, ref indexTeam1)
         }
        }

        if sorcerer2.health == 0 {
            indexTeam2 = indexTeam2 + 1;
            if indexTeam2 != team2.len() {
             sorcerer2 = getSorcerer(ref team2, ref indexTeam2)
            }
        }

        /// finish team1
            if (indexTeam1 == team1.len() && indexTeam2 != team2.len()){
                let mut finalWinTeam2 = ArrayTrait::new();
                finish(ref team2, ref finalWinTeam2, ref indexTeam2, ref sorcerer2);
                team2 = finalWinTeam2;
                team1 = ArrayTrait::new();
                break;            
                 }

         ////finish team 2

            if (indexTeam2 == team2.len() && indexTeam1 != team1.len()){
                let mut finalWinTeam1 = ArrayTrait::new();
                finish(ref team1, ref finalWinTeam1, ref indexTeam1, ref sorcerer1);
                team1 = finalWinTeam1;
                team2 = ArrayTrait::new();
                break;            
        }   

            if (indexTeam2 == team2.len() && indexTeam1 == team1.len()) {
                team1 = ArrayTrait::new();
                team2 = ArrayTrait::new();
                break;
            }
     }
}

fn finish( ref team:Array<Sorcerer>, ref finalTeam:Array<Sorcerer>, ref index: u32,  ref sorcerer: Sorcerer ) {
            
            finalTeam.append(sorcerer);
            index = index + 1;
            while index < team.len() {
                finalTeam.append(getSorcerer(ref team, ref index));
                index = index + 1;

            };
}

fn getSorcerer( ref fromTeam: Array<Sorcerer>, ref index: u32) -> Sorcerer {
    *fromTeam.get(index).unwrap().unbox()
}    

