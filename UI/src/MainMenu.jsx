import { useContext, useEffect, useRef } from "react";
import { Data, RouteCtx } from "./App";
import axios from "axios";

function MainMenu({ transferedRides, rides }) {
  const setRoute = useContext(RouteCtx);
  const exitRequestedRef = useRef(false);
  const Lang = Data.Lang || {};
  const currentChar = Data.characters?.find(c => c.charidentifier === Data.player?.characterId) || {};

  useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key !== "Backspace") return;
      if (exitRequestedRef.current) return;

      exitRequestedRef.current = true;
      window.__BRK_STABLE_EXITING = true;

      axios.post(`https://${GetParentResourceName()}/exit`).catch(() => {});
      setRoute("/exit");
    };

    document.onkeydown = handleKeyDown;

    return () => {
      if (document.onkeydown === handleKeyDown) {
        document.onkeydown = null;
      }
    };
  }, [setRoute]);

  return (
    <div className="menu-wrap">
      <h1>{Lang.Stable || "Stable"}</h1>
      <menu>
        {
          !Data.DisableBuyOption &&
          (
            !Data.JobRequired ||
            currentChar.job === Data.JobForHorseDealer ||
            currentChar.job === Data.JobForAllDealer
          ) &&
          <span onClick={() => setRoute("/buyhorse")}>{Lang.BuyAHorse || "Buy Horse"}</span>
        }

        {
          !Data.DisableBuyOption &&
          (
            !Data.JobRequired ||
            currentChar.job === Data.JobForCartDealer ||
            currentChar.job === Data.JobForAllDealer
          ) &&
          <span onClick={() => setRoute("/buycart")}>{Lang.BuyACart || "Buy Cart"}</span>
        }

        {
          rides && rides.length
            ? <span onClick={() => setRoute("/myrides")}>{Lang.MyRides || "My Rides"}</span>
            : null
        }

        {
          transferedRides && transferedRides.length
            ? <span onClick={() => setRoute("/recieve")}>{Lang.RidesAwaitingTransfer || "Rides Awaiting Transfer"}</span>
            : null
        }
      </menu>
    </div>
  );
}

export default MainMenu;