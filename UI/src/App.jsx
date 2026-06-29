import MainMenu from './MainMenu'
import "./styles/main.sass"
import BuyRideMenu, { RideTypes } from './BuyRideMenu'
import { BRK_STABLES_REWORK } from "./Metadata";
import { createContext, useEffect, useState } from 'react'
import MyRidesMenu from './MyRidesMenu';
import BuyCompsMenu from './BuyCompsMenu';
import TransferModal from './TransferMenu';
import TransferRecieve from './TransferRecieve';
import TackStorageMenu from './TackStorageMenu';

let Data = {};
const RouteCtx = createContext();

function App() {
  const [m_Data, setM_Data] = useState(Data);
  const [display, setDisplay] = useState(false);
  const [route, setRoute] = useState("/");

  useEffect(() => {
    window.__BRK_STABLES_REWORK = BRK_STABLES_REWORK;

    function handleMessage(mess) {
      let payload = mess.data;

      if (typeof payload === "string") {
        try {
          payload = JSON.parse(payload);
        } catch {
          return;
        }
      }

      if (!payload || !payload.type) return;

      const { type, content } = payload;

      if (type === "registerConfig") {
        Data = {
          ...Data,
          ...content,
          ...(content?.StaticData || {}),
          StaticData: null
        };
        setM_Data({ ...Data });
      }
      else if (type === "open") {
        window.__BRK_STABLE_EXITING = false;
        Data.player = content?.player || {};
        Data.current = content?.current || {};
        setDisplay(true);
        setM_Data({ ...Data });
      }
      else if (type === "refresh") {
        Data.player = content?.player || {};
        Data.current = content?.current || {};
        setM_Data({ ...Data });
      }
      else if (type === "refreshChars") {
        Data.characters = content || [];
        setM_Data({ ...Data });
      }
    }

    window.addEventListener("message", handleMessage);
    return () => window.removeEventListener("message", handleMessage);
  }, []);

  useEffect(() => {
    if (route === "/exit") {
      setDisplay(false);
      setRoute("/");
    }
  }, [route]);

  useEffect(() => {
    if (route === "/myrides" && display && !(m_Data.player?.rides?.length)) {
      setRoute("/");
    }
  }, [route, display, m_Data.player?.rides]);

  if (!display) return null;
  if (!m_Data?.player || !m_Data?.current) return null;

  const player = m_Data.player;
  const current = m_Data.current;

  return (
    <RouteCtx.Provider value={setRoute}>
      {
        route === "/" && <MainMenu transferedRides={player.transferedRides || []} rides={player.rides || []} /> ||
        route === "/buyhorse" && <BuyRideMenu rideType={RideTypes.horse} currentRidesList={{ carts: current.carts || m_Data.Carts || {}, horses: current.horses || m_Data.Horses || {} }} /> ||
        route === "/buycart" && <BuyRideMenu rideType={RideTypes.cart} currentRidesList={{ carts: current.carts || m_Data.Carts || {}, horses: current.horses || m_Data.Horses || {} }} /> ||
        route.startsWith("/buycomps") && <BuyCompsMenu Comps={m_Data.Complements || {}} buyable={true} horseId={Number(route.split("?")[1])} /> ||
        route.startsWith("/changecomps") && <BuyCompsMenu Comps={player.availableComps || {}} buyable={false} horseId={Number(route.split("?")[1])} /> ||
        route.startsWith("/tackstorage") && <TackStorageMenu horseId={Number(route.split("?")[1])} /> ||
        route === "/myrides" && <MyRidesMenu Data={player} /> ||
        route.startsWith("/transfer") && <TransferModal
          rideId={Number(route.split("?")[1])}
          rideName={player.rides?.find(r => r.id == Number(route.split("?")[1]))?.name || "Ride"}
          characters={m_Data.characters || []}
        /> ||
        route.startsWith("/recieve") && player.transferedRides?.length && <TransferRecieve
          rideId={Number(player.transferedRides[0].id)}
          rideName={player.transferedRides[0].name}
          characters={m_Data.characters || []}
          giverId={player.transferedRides[0].owner}
          price={player.transferedRides[0].price}
        /> ||
        route === "/exit" && null
      }
    </RouteCtx.Provider>
  )
}

export default App
export { Data, RouteCtx }
