--ds_basic_lists.lua
--Druidensystem
--Wiederkehrende Listen
--Falk
--Diese Listen m�ssen bei Grafik-Updates jeweils �berpr�ft werden !!!

module("druid.base.lists", package.seeall)

function basicLists()
	ListeObjMetall 		= {1,4,6,7,9,16,18,19,20,23,24,25,27,47,74,77,78,88,94,95,96,101,184,185,186,187,188,189,190,126,202,204,205,207,226,230,231,271,311,324,325,326,383,916,1858,2111,2112,2116,2117,2140,2172,2284,2286,2287,2290,2291,2302,2357,2359,2360,2363,2364,2365,2367,2369,2388,2389,2390,2393,2395,2399,2400,2403,2407,2441,2444,2629,2635,2642,2645,2658,2660,2675,2701,2711,2723,2725,2731,2738,2740,2746,2715,2752,2757,2763,2775,2778}
	ListeObjNahrung		= {554,555,556,557,559,2276,2278,2456,2459,2922,2923,2940,3051}
	ListeObjLeder  		= {4,17,18,19,20,48,53,95,96,97,101,186,293,325,326,362,363,364,365,366,367,369,916,2111,2112,2116,2117,2172,2284,2286,2287,2290,2291,2302,2357,2359,2360,2363,2364,2365,2367,2369,2388,2389,2390,2393,2395,2399,2400,2403,2407,2441,2445,2448}  
	ListeObjEdelstein = {57,68,76,225,277,278,279,280,281,282,336,2284,2357,2367,2400,2731}   
	ListeObjEdelMet		= {68,95,190,224,225,235,277,278,279,280,281,282,336,383,916,1001,1840,2031,2284,2286,2287,2290,2359,2360,2363,2365,2367,2369,2390,2400,2407,2550,2647,2660,2731}
	ListeObjHolz   		= {1,9,17,23,24,25,27,39,40,51,57,64,70,72,74,76,77,78,88,90,118,121,126,188,189,190,204,205,207,208,209,226,230,231,237,258,271,277,293,312,332,335,383,734,2185,2193,2194,2445,2448,2525,2527,2528,2530,2541,2544,2548,2549,2561,2566,2567,2570,2572,2573,2584,2585,2629,2635,2636,2642,2645,2646,2658,2660,2675,2685,2701,2708,2711,2714,2715,2718,2719,2723,2725,2731,2740,2746,2752,2705,2744,2757,2763,2775,2778,2781,2935,2952}
	ListeObjStoff  		= {34,55,180,181,182,183,193,194,195,196,356,357,358,368,370,385,547,548,558,2295,2377,2378,2380,2384,2416,2418,2419,2420,2421,}  
--F�r Horn, Fell, Seil, Knochen
	ListeObjHorn 			= {7,16,39,366,367,2113,2114}

end
	