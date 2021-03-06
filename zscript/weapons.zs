/**
 * Copyright (c) 2017-2019 DRRP-Team
 * 
 * This software is released under the MIT License.
 * https://opensource.org/licenses/MIT
 */

class DRRPPistol : Pistol replaces Pistol {
    Default {
        DamageType "DRRPClipDmg";
        Decal "BulletChip";
    }

    States {
        Fire:
            PISG A 4;
            PISG B 0 A_FireBullets(5.6, 0, 1, Random(6, 7), "BulletPuff", FBF_NORANDOM + FBF_USEAMMO);
            PISG B 0 A_PlaySound("weapons/pistol", CHAN_WEAPON);
            PISG B 1 A_GunFlash;
            PISG A 0 A_ZoomFactor(FRandom(0.995, 0.999), ZOOM_INSTANT);
            PISG B 0 A_SetAngle(Angle + FRandom(-0.3, 0.3));
            PISG B 2 Bright A_SetPitch(Pitch - FRandom(-0.1, 0.4));
            PISG B 0 A_ZoomFactor(1);
            PISG B 0 Bright A_SetPitch(Pitch - FRandom(-0.3, 0.3));
            PISG B 1;
            PISG B 0 Bright A_SetPitch(Pitch + FRandom(0.2, 0.4));
            PISG B 2;
            PISG C 4;
            PISG B 5 A_ReFire;
            Goto Ready;
    }
}

class DRRPShotgun : Shotgun replaces Shotgun {
    Default {
        DamageType "DRRPShotgunDmg";
        Decal "BulletChip";
        Weapon.AmmoType "DRRPShell";
    }

    States {
        Fire:
            SHTG A 3;
            SHTG A 2 {
                A_FireBullets( 5.6, 0, 4, 1, "BulletPuff", FBF_NORANDOM + FBF_USEAMMO );
                A_FireBullets( 5.6, 0, 3, Random( 1, 2 ), "BulletPuff", FBF_NORANDOM );
                A_GunFlash();
                A_PlaySound( "weapons/shotgf", CHAN_WEAPON );
            }
            SHTG A 5;
            SHTG B 1;
            SHTG CD 2;
            SHTG E 1;
            SHTG FG 2;
            SHTG HI 3;
            SHTG JIH 2;
            SHTG GFE 1;
            SHTG DCB 2;
            Goto Ready;
        Flash:
            TNT1 A 0 A_Light1;
            SHTF A 1 Bright A_SetPitch(Pitch - FRandom(-0.1, 0.4));
            SHTF A 1 Bright;
            SHTF A 0 A_ZoomFactor(FRandom(0.985, 0.999));
            SHTF A 0 A_Recoil(0.5);
            SHTF A 0 A_SetAngle(Angle + FRandom(-1.5, 1.5));
            SHTF A 1 Bright A_SetPitch(Pitch - FRandom(-0.1, 0.5));
            SHTF A 0 A_SetAngle(Angle + FRandom(-1, 1));
            SHTF A 1 Bright A_SetPitch(Pitch - FRandom(0.2, 1));
            SHTF B 0 A_ZoomFactor(1);
            SHTF B 0 A_Light2;
            SHTF B 3 Bright;
            Goto LightDone;
    }
}

class DRRPShell : Ammo replaces Shell {
    Default {
        Inventory.PickupMessage "$GOTSHELLS"; // "Picked up 4 shotgun shells."
        Inventory.Amount 4;
        Inventory.MaxAmount 99;
        Ammo.BackpackAmount 4;
        Ammo.BackpackMaxAmount 99;
        Inventory.Icon "SHELA0";
    }
    States {
    Spawn:
        SHEL A -1;
        Stop;
    }
}

class DRRPShellBox : DRRPShell replaces ShellBox {
    Default {
        Inventory.PickupMessage "$GOTSHELLBOX";
        Inventory.Amount 16;
    }
}

class DRRPSuperShotgun : SuperShotgun replaces SuperShotgun {
    Default {
        DamageType "DRRPSSGDmg";
        Decal "BulletChip";
        Weapon.AmmoType "DRRPShell";
    }

    States {
        Fire:
            SHT2 A 0 A_FireBullets( 11.2, 7.1, 4, Random(2, 5), "BulletPuff", FBF_NORANDOM );
            SHT2 A 1 A_FireBullets( 11.2, 7.1, 16, 1, "BulletPuff", FBF_NORANDOM + FBF_USEAMMO );
            SHT2 A 0 A_PlaySound( "weapons/sshotf" );
            SHT2 A 2 A_GunFlash;
            SHT2 A 4;
            SHT2 A 3 A_CheckReload;
            SHTD BC 2;
            SHTD D 3;
            SHT2 A 0 A_PlaySound( "weapons/sshoto", CHAN_WEAPON );
            SHTD EF 3;
            SHTD G 6 A_GunFlash( "DoubleShellFallFlash" );
            SHTD H 2;
            SHTD IJ 3;
            SHTD K 3 A_LoadShotgun2;
            SHTD LMNO 3;
            SHTD P 2 A_PlaySound( "weapons/sshotc", CHAN_WEAPON );
            SHTD Q 3;
            SHTD RS 3;
            SHT2 A 2;
            Goto Ready;
        DoubleShellFallFlash:
            CAS1 ABCD 2;
            Stop;
        Flash:
            SHT2 I 0 A_SetPitch(Pitch - FRandom(-0.9, 1.9));
            SHTF A 0 A_SetAngle(Angle + FRandom(-1.0, 1.0));
            SHT2 I 1 Bright A_Light1;
            SHT2 I 0 A_SetPitch(Pitch - FRandom(-0.3, 1.9));
            SHTF A 0 A_Recoil(1);
            SHTF A 0 A_SetAngle(Angle + FRandom(-1.6, 1.6));
            SHT2 I 1 Bright A_SetPitch(Pitch - FRandom(-0.45, 1.5));
            SHTF A 0 A_ZoomFactor(FRandom(0.92, 0.95));
            SHT2 I 1 Bright A_SetPitch(Pitch - FRandom(-0.4, 0.8));
            SHTF A 0 A_SetAngle(Angle + FRandom(-0.4, 0.4));
            SHT2 I 1 Bright A_SetPitch(Pitch - FRandom(-0.3, 0.6));
            SHT2 I 0 Bright A_ZoomFactor(0.95);
            SHT2 J 1 Bright A_Light2;
            SHT2 I 0 Bright A_ZoomFactor(0.97);
            SHT2 J 1 Bright A_Light2;
            SHT2 I 0 Bright A_ZoomFactor(0.99);
            SHT2 J 1 Bright A_Light2;
            SHT2 I 0 Bright A_ZoomFactor(1);
            Goto LightDone;
    }
}

class DRRPChaingun : Chaingun replaces Chaingun {
    Default {
        DamageType "DRRPClipDmg";
        Decal "BulletChip";
    }

    States {
        Fire:
            CHGG A 0 A_PlaySound("weapons/chngun", CHAN_WEAPON);
            CHGG A 0 A_GunFlash;
            CHGG A 2 A_FireBullets(5.6, 0, 1, Random(4, 10), "BulletPuff", FBF_NORANDOM + FBF_USEAMMO);
            CHGG B 2;
            CHGG C 0 A_PlaySound("weapons/chngun", CHAN_WEAPON);
            CHGG C 0 A_GunFlash("Flash2");
            CHGG C 2 A_FireBullets(5.6, 0, -1, Random(5, 8), "BulletPuff", FBF_NORANDOM + FBF_USEAMMO);
            CHGG D 2;
            CHGG C 0 A_ReFire;
            Goto Ready;
        Flash:
            CHGF A 0 Bright A_ZoomFactor(FRandom(0.994, 1), ZOOM_INSTANT);
            CHGF A 0 Bright A_SetPitch(Pitch - FRandom(-0.2, 0.7));
            CHGF A 0 Bright A_SetAngle(Angle + FRandom(-0.4, 0.2));
            CHGF A 1 Bright A_Light1;
            CHGF A 0 A_Recoil(0.03);
            CHGF A 0 A_SetPitch(Pitch - FRandom(-0.2, 0.4));
            CHGF A 0 A_SetAngle(Angle + FRandom(-0.2, 0.1));
            CHGF A 0 A_ZoomFactor(1);
            CHGF A 0 A_Jump( 95, 1 );
            Goto LightDone;
            CHGF A 1 Bright A_Light1;
            Goto LightDone;
        Flash2:
            CHGF B 0 Bright A_ZoomFactor(FRandom(0.995, 0.999), ZOOM_INSTANT);
            CHGF B 0 Bright A_SetPitch(Pitch - FRandom(-0.2, 0.7));
            CHGF B 0 Bright A_SetAngle(Angle + FRandom(-0.4, 0.2));
            CHGF B 1 Bright A_Light1;
            CHGF B 0 A_ZoomFactor(1);
            CHGF B 0 A_Recoil(0.03);
            CHGF B 0 A_SetPitch(Pitch - FRandom(-0.2, 0.4));
            CHGF B 0 A_SetAngle(Angle + FRandom(-0.2, 0.1));
            CHGF B 0 A_Jump( 95, 1 );
            Goto LightDone;
            CHGF B 1 Bright A_Light2;
            Goto LightDone;
    }
}

class DRRPRocketLauncher : RocketLauncher replaces RocketLauncher {
    States {
        Fire:
            MISG B 10 A_GunFlash;
            MISG B 10;
            MISG B 0 A_ReFire;
            Goto Ready;
        Flash:
            TNT1 A 0 A_AlertMonsters;
            TNT1 A 0 A_FireMissile; // Dmg. : 15-36.
            TNT1 A 0 A_Recoil(0.02 * Height);
            TNT1 A 0 A_SetPitch(Pitch - 0.1 * Height);
            TNT1 A 0 A_SetAngle(Angle + FRandom(-2.5, 2.5) * 0.02 * Height);
            TNT1 A 0 A_Light2;
            MISF AAAA 1 Bright A_SetPitch(Pitch + 0.005 * Height);
            TNT1 C 0 A_Light1;
            MISF BBBB 1 Bright A_SetPitch(Pitch + 0.005 * Height);
            TNT1 A 0 A_Light0;
            MISF CCCDDD 1 Bright A_SetPitch(Pitch + 0.005 * Height);
            TNT1 AAAAAAA 1 A_SetPitch(Pitch + 0.005 * Height);
            Goto LightDone;
            MISF A 3 Bright A_Light1;
            MISF B 4 Bright;
            MISF CD 4 Bright A_Light2;
            Goto LightDone;
    }
}

class DRRPRocket : Rocket replaces Rocket {
    States {
        Death:
            MISL B 8 Bright A_Explode(15 + Random(0, 21), 128);
            MISL C 6 Bright;
            MISL D 4 Bright;
            Stop;
    }
}

class DRRPPlasmagun : PlasmaRifle replaces PlasmaRifle {
    States {
        Fire:
            PLSG A 0 A_GunFlash;
            PLSG A 3 A_FireProjectile( "PlasmaBall" );
            PLSG B 0 A_ReFire;
            PLSG B 0 A_ZoomFactor( 1 );
            PLSG A 2;
            PLSG B 1;
            PLSG DEF 2;
            PLSG G 4;
            PLSG H 9;
            PLSG G 2;
            PLSG FED 1;
            PLSG CBA 2;
            Goto Ready;
        Flash:
            PLSF A 0 A_SetPitch(Pitch - FRandom(0.05, 0.4));
            PLSF A 0 A_SetAngle(Angle + FRandom(-0.2, 0.2));
            PLSF A 0 A_Recoil(0.075);
            PLSG B 0 A_ZoomFactor(FRandom(0.995, 0.999));
            PLSF A 0 A_Jump(127, "Flash2");
            PLSF A 4 Bright A_Light1;
            Goto LightDone;
        Flash2:
            PLSF B 4 Bright A_Light1;
            Goto LightDone;
    }
}

class DRRPBFG9000 : BFG9000 replaces BFG9000 {

    Default {
        Weapon.AmmoUse 30;
    }

    States {
        Fire:
            BFGG A 20 A_BFGSound;
            BFGG B 10 A_GunFlash;
            BFGG B 10 A_FireBFG;
            BFGG B 20 A_ReFire;
            Goto Ready;
        Flash:
            BFGF A 3 Bright A_Light1;
            BFGF A 1 Bright A_Quake(1, 6, 0, 0);
            BFGF AAAA 2 Bright {
                A_SetAngle(Angle + FRandom(-0.5, 0.5));
                A_SetPitch(Pitch + FRandom(-0.35, 0.35));
                A_Recoil(FRandom(0.02, 0.35));
            }
            BFGF B 0 Bright {
                A_SetBlend("44FF44", 0.8, Random(40, 60));
                A_SetPitch(Pitch - FRandom(2.5, 5));
                A_Recoil(FRandom(0.5, 1.5));
                A_Light2();
                A_ZoomFactor(0.86, ZOOM_INSTANT);
            }
            BFGF BBB 1 Bright {
                A_SetAngle(Angle + FRandom(-1.5, 1.5));
                A_SetPitch(Pitch + FRandom(-1, 1));
                A_Recoil(FRandom(0.1, 0.75));
                A_ZoomFactor(0.885);
            }
            BFGF BBB 1 Bright {
                A_SetAngle(Angle + FRandom(-0.5, 0.5));
                A_SetPitch(Pitch + FRandom(-0.35, 0.35));
                A_ZoomFactor(0.91);
            }
            TNT1 A 1 Bright A_ZoomFactor(0.935);
            TNT1 A 1 Bright A_ZoomFactor(0.9475);
            TNT1 A 1 Bright A_ZoomFactor(0.955);
            TNT1 A 1 Bright A_ZoomFactor(0.9625);
            TNT1 A 1 Bright A_ZoomFactor(0.97);
            TNT1 A 1 Bright A_ZoomFactor(0.98);
            TNT1 A 1 Bright A_ZoomFactor(0.99);
            TNT1 A 0 Bright A_ZoomFactor(1);
            Goto LightDone;
    }
}
