import { useContext, useEffect, useState } from "react";
import { Data, RouteCtx } from "./App";
import axios from 'axios';
function BuyRideMenu({ rideType, currentRidesList }) {
  const [displayedRide, setDisplayedHorse] = useState(null);
  const [currentCat, setCurrentCat] = useState(null);
  const [currentCatName, setCurrentCatName] = useState(null);
  const [timer, setTimer] = useState(true);
  const setRoute = useContext(RouteCtx)

  useEffect(() => {
    const handleKeyDown = (e) => {
      if (window.__BRK_STABLE_EXITING) return;

      if (e.key === "Backspace") {
        currentCat !== null
          ? setCurrentCat(null)
          : setRoute("/");
      }
    };

    document.onkeydown = handleKeyDown;

    return () => {
      if (document.onkeydown === handleKeyDown) {
        document.onkeydown = null;
      }
    };
  }, [currentCat, setRoute]);

  useEffect(() => {
    if (window.__BRK_STABLE_EXITING) return;
    axios.post(`https://${GetParentResourceName()}/activateCam`, { rideType }).catch(() => {})
  }, [rideType]);

  function showRideAndPromptValidation(rideName) {
    if (!timer) return;
        axios.post(`https://${GetParentResourceName()}/showRide`, {
        rideType,
        rideName
          }).catch(() => {})
    setDisplayedHorse(rideName);
    setTimer(false);
    setTimeout(() => setTimer(true), 500)
  }

function DisplayRidesFromType() {
    let obj;
    switch (rideType) {
      case RideTypes.horse:
        obj = currentCat || formatRidesObject(Data.current?.horses || {}, rideType);
        if (!currentCat && isGroupedObject(obj)) {
          return Object.entries(obj).map(([catName, catObj]) => (
            <span key={catName} onClick={(e) => {
              e.stopPropagation();
              setCurrentCat(catObj);
              setCurrentCatName(catName);
            }}>
              <label>{Data.Lang[catName] || catName}</label>
            </span>
          ));
        }
        return Object.entries(obj).map(DisplayNoNesting);
      case RideTypes.cart:
        obj = currentCat || formatRidesObject(Data.current?.carts || {}, rideType);
        return Object.keys(obj).length >= 10 && !currentCat
          ? categorize(obj, rideType)
          : Object.entries(obj).map(DisplayNoNesting);
    }
  }

function isGroupedObject(obj) {
    if (!obj || typeof obj !== "object") return false;
    return Object.values(obj).some((value) => {
      return (
        value &&
        typeof value === "object" &&
        !value.price &&
        !value.currency
      );
    });
  }

function formatRidesObject(obj, rideType) {
    if (!obj || Object.keys(obj).length === 0) {
        return Data[rideType == RideTypes.horse ? "Horses" : "Carts"];
    }
    const dataList = Data[rideType == RideTypes.horse ? "Horses" : "Carts"];
    const retVal = {};
    function buildRide(model, value) {
        if (typeof value === "object") {
            return {
                name: value.name || model,
                price: value.price || dataList[model],
                currency: value.currency || 0
            };
        }
        if (typeof value === "number") {
            return {
                name: model,
                price: value,
                currency: 0
            };
        }
        return {
            name: value || model,
            price: dataList[model],
            currency: 0
        };
    }
    for (const key in obj) {
        const value = obj[key];
        if (!isNaN(Number(key))) {
            const entry = value;
            if (typeof entry === "string") {
                retVal[entry] = buildRide(entry, entry);
            } else {
                Object.entries(entry).forEach(([model, rideData]) => {
                    retVal[model] = buildRide(model, rideData);
                });
            }
        } else if (
            typeof value === "object" &&
            !value.price &&
            !value.currency &&
            !dataList[key]
        ) {
            retVal[key] = formatRidesObject(value, rideType);
        } else {
            retVal[key] = buildRide(key, value);
        }
    }
    return retVal;
}

  function categorize(rides, rideType) {
    const categories = {};
    const others = ["A_C_HorseMulePainted_01", "A_C_HorseMule_01", "A_C_Horse_MP_Mangy_Backup"]
    if (rideType == RideTypes.horse) {
      Object.entries(rides).forEach(([rideName, ridePrice]) => {
        if (!rideName) return;
        if (others.includes(rideName)) {
          categories.others ? categories.others[rideName] = ridePrice : categories.others = { [rideName]: ridePrice };
          return;
        }
        const upRideName = rideName.toUpperCase();
        let cat = upRideName.split("A_C_HORSE_")[1]?.split("_")[0]
        if (cat) {
          categories[cat] ? categories[cat][rideName] = ridePrice : categories[cat] = { [rideName]: ridePrice };
          return;
        }
      });
      return Object.entries(categories).sort((a,b) => a[0].localeCompare(b[0])).map(([catName, catObj]) => <span key={catName} onClick={(e) => {
        setCurrentCat(catObj)
        setCurrentCatName(catName)
      }}>
        <label>{Data.Lang[catName] || catName}</label>
      </span>
      )
    }
    else if (rideType == RideTypes.cart) {
      const cartTypes = [
        "buggy",
        "cart",
        "chuckwagon",
        "wagon",
        "coach",
        "stagecoach",
        "logwagon",
        "supplywagon",
      ]
      Object.entries(rides).forEach(([rideName, ridePrice]) => {
        if (!rideName) return;
        for (const cat of cartTypes) {
          if(rideName.startsWith(cat)){
            categories[cat] ? categories[cat][rideName] = ridePrice : categories[cat] = { [rideName]: ridePrice };
            return;
          }
        }
        categories.others ? categories.others[rideName] = ridePrice : categories.others = { [rideName]: ridePrice };
      });
      return Object.entries(categories).sort((a,b) => a[0].localeCompare(b[0])).map(([catName, catObj]) => <span key={catName} onClick={(e) => {
        setCurrentCat(catObj)
        setCurrentCatName(catName)
      }}>
        <label>{Data.Lang[catName] || catName}</label>
      </span>
      )
    }
  }

function DisplayNoNesting([rideModel, rideData]) {
    const price = typeof rideData === "object" ? rideData.price : rideData;
    const currency = typeof rideData === "object" ? rideData.currency : 0;
    const label = typeof rideData === "object" ? rideData.name : rideModel;
    const priceText = `${price}${currency == 1 ? " gold" : ""}`;
    return <span key={rideModel} onClick={(e) => {
      e.stopPropagation();
      displayedRide !== rideModel && showRideAndPromptValidation(rideModel);
    }}>
      <label>{label || Data.Lang[rideModel] || rideModel}</label>
      {
        displayedRide === rideModel
          ? <button onClick={(e) => {
            e.stopPropagation();
              axios.post(`https://${GetParentResourceName()}/buyRide`, {
                rideType,
                rideModel
              }).catch(() => {})
          }}>{Data.Lang.BuyFor.replace("{price}", priceText)}</button>
          : <i className="price">{Data.Lang.DollarBeforeOrAfterPrice.replace("{price}", priceText)}</i>
      }
    </span>
  }

  return (
    <div className="menu-wrap">
      <h1>{
        currentCat
          ? `${Data.Lang.BuyA} ${currentCatName}`
          : `${rideType === RideTypes.horse ? Data.Lang.BuyA : Data.Lang.BuyA2} ${rideType === RideTypes.horse ? Data.Lang.horse : Data.Lang.cart}`
      }</h1>
      <menu>
        <DisplayRidesFromType />
      </menu>
    </div>
  )
}
const RideTypes = {
  cart: "cart",
  horse: "horse"
}
export default BuyRideMenu;
export {
  RideTypes
}