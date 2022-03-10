%let pgm=utl-compute-column-in-proc-report-works-like-the-datastep ;

Compute column in proc report works like the datastep

    Two Solutions

         1. Change order in column statement so height and weight is available before bmi

         2. Use alias names so that bmi can appear after name but before height and weight
            Freelance Richard
            https://communities.sas.com/t5/user/viewprofilepage/user-id/32733

github
https://tinyurl.com/yc562kk5
https://github.com/rogerjdeangelis/utl-compute-column-in-proc-report-works-like-the-datastep

sas communities;
https://tinyurl.com/2yapn4tr
https://communities.sas.com/t5/SAS-Programming/proc-report-problem-with-computed-col/m-p/800584


/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

Variables must be defined they can be used in compute block

Problem: Compute BMI with proc report (missing bmi in my report)

   proc report data=sashelp.class;

    column name bmi height weight; * need to move bmi to last for this to work;

     define name   / display "Student";
     define height / display "Height" ;
     define weight / display "Weight";
     define bmi   / computed  "BMI" format=5.2;    * even though it appears after here;
                                                   * column statement sets order fo operation;
     compute bmi;
        bmi= weight * 703 / (height * height);
     endcomp;

   run;quit;


/**************************************************************************************************************************/
/*                                                                                                                        */
/* The column statement sets the order of the operations bmi cannot come before height and weight defined                 */
/*                                                                                                                        */
/*  BMI is missing                                                                                                        */
/*                                                                                                                        */
/*  Student     BMI     Height     Weight                                                                                 */
/*  Alfred      .           69      112.5                                                                                 */
/*  Alice       .         56.5         84                                                                                 */
/*  Barbara     .         65.3         98                                                                                 */
/*  Carol       .         62.8      102.5                                                                                 */
/*  Henry       .         63.5      102.5                                                                                 */
/*  James       .         57.3         83                                                                                 */
/*  Jane        .         59.8       84.5                                                                                 */
/*                                                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  _               _          __ _                           _       _     _                                             */
/* | |__  _ __ ___ (_)   __ _ / _| |_ ___ _ __  __      _____(_) __ _| |__ | |_                                           */
/* | `_ \| `_ ` _ \| |  / _` | |_| __/ _ \ `__| \ \ /\ / / _ \ |/ _` | `_ \| __|                                          */
/* | |_) | | | | | | | | (_| |  _| ||  __/ |     \ V  V /  __/ | (_| | | | | |_                                           */
/* |_.__/|_| |_| |_|_|  \__,_|_|  \__\___|_|      \_/\_/ \___|_|\__, |_| |_|\__|                                          */
/*                                                              |___/                                                     */
/*                                                                                                                        */
/*    Student      Height     Weight    BMI                                                                               */
/*    -------------------------------------                                                                               */
/*                                                                                                                        */
/*    Alfred           69      112.5  16.61                                                                               */
/*    Alice          56.5         84  18.50                                                                               */
/*    Barbara        65.3         98  16.16                                                                               */
/*    Carol          62.8      102.5  18.27                                                                               */
/*    Henry          63.5      102.5  17.87                                                                               */
/*    James          57.3         83  17.77                                                                               */
/*    Jane           59.8       84.5  16.61                                                                               */
/*                                                                                                                        */
/*   _               _          __ _                                                                                      */
/*  | |__  _ __ ___ (_)   __ _ / _| |_ ___ _ __   _ __   __ _ _ __ ___   ___                                              */
/*  | `_ \| `_ ` _ \| |  / _` | |_| __/ _ \ `__| | `_ \ / _` | `_ ` _ \ / _ \                                             */
/*  | |_) | | | | | | | | (_| |  _| ||  __/ |    | | | | (_| | | | | | |  __/                                             */
/*  |_.__/|_| |_| |_|_|  \__,_|_|  \__\___|_|    |_| |_|\__,_|_| |_| |_|\___|                                             */
/*                                                                                                                        */
/*    Student     BMI     Height     Weight                                                                               */
/*    -------------------------------------                                                                               */
/*                                                                                                                        */
/*    Alfred    16.61         69      112.5                                                                               */
/*    Alice     18.50       56.5         84                                                                               */
/*    Barbara   16.16       65.3         98                                                                               */
/*    Carol     18.27       62.8      102.5                                                                               */
/*    Henry     17.87       63.5      102.5                                                                               */
/*    James     17.77       57.3         83                                                                               */
/*    Jane      16.61       59.8       84.5                                                                               */
/*    Janet     20.25       62.5      112.5                                                                               */
/*                                                                                                                        */
/*                                                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
 _     _               _   _           _     _             _
/ |   | |__  _ __ ___ (_) | | __ _ ___| |_  (_)___    ___ | | __
| |   | `_ \| `_ ` _ \| | | |/ _` / __| __| | / __|  / _ \| |/ /
| |_  | |_) | | | | | | | | | (_| \__ \ |_  | \__ \ | (_) |   <
|_(_) |_.__/|_| |_| |_|_| |_|\__,_|___/\__| |_|___/  \___/|_|\_\

*/

proc report data=sashelp.class;

 column
        name
        height
        weight
        bmi;    * BMI on the end after all variables are initialized;

  define name   / display "Student";
  define height / display "Height" ;
  define weight / display "Weight";
  define bmi   / computed  "BMI" format=5.2;

  compute bmi;
     bmi= weight * 703 / (height * height);
  endcomp;

run;quit;



/*___      _               _          __ _
|___ \    | |__  _ __ ___ (_)   __ _ / _| |_ ___ _ __   _ __   __ _ _ __ ___   ___
  __) |   | `_ \| `_ ` _ \| |  / _` | |_| __/ _ \ `__| | `_ \ / _` | `_ ` _ \ / _ \
 / __/ _  | |_) | | | | | | | | (_| |  _| ||  __/ |    | | | | (_| | | | | | |  __/
|_____(_) |_.__/|_| |_| |_|_|  \__,_|_|  \__\___|_|    |_| |_|\__,_|_| |_| |_|\___|
*/


proc report data=sashelp.class headline headskip nowd missing;

 column
        name
        height=intitialized_height
        weight=intitialized_weight
        bmi
        height
        weight
  ;

  define name                / display "Student"         ;
  define intitialized_height / noprint                   ;
  define intitialized_weight / noprint                   ;
  define bmi                 / computed  "BMI" format=5.2;
  define height              / display "Height"          ;
  define weight              / display "Weight"          ;

  compute bmi; /* use intialized variables */
     bmi= intitialized_weight * 703 / (intitialized_height ** 2);
  endcomp;

run;quit;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/



