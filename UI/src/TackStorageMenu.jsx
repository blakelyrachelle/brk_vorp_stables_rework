import { useContext, useEffect, useState } from "react";
import { Data, RouteCtx } from "./App";
import axios from "axios";

const TackColumnByType = {
  "Saddles": "saddles",
  "Blankets": "blankets",
  "Saddle Horns": "saddle_horns",
  "Saddlebags": "saddlebags",
  "Stirrups": "stirrups",
  "Bedrolls": "bedrolls",
  "Lanterns": "lanterns",
  "Masks": "masks"
};

function parseStoredList(value) {
  if (!value) return [];

  if (Array.isArray(value)) return value;

  try {
    const parsed = JSON.parse(value);
    return Array.isArray(parsed) ? parsed : [];
  } catch {
    return [];
  }
}

function TackStorageMenu({ horseId }) {
  const setRoute = useContext(RouteCtx);
  const [compType, setCompType] = useState(null);
  const [selectedHash, setSelectedHash] = useState(null);

  const storageRow = Array.isArray(Data.player?.tackStorage)
    ? Data.player.tackStorage[0]
    : Data.player?.tackStorage;

  useEffect(() => {
    document.onkeydown = (e) => {
      if (e.key === "Backspace") {
        if (compType) {
          setCompType(null);
          setSelectedHash(null);
        } else {
          setRoute("/myrides");
        }
      }
    };
  });

  function getStoredList(typeName) {
    const column = TackColumnByType[typeName];
    return parseStoredList(storageRow?.[column]);
  }

  function preview(hash) {
    setSelectedHash(hash);

    axios.post(`https://${GetParentResourceName()}/viewComp`, {
      modelHash: hash,
      type: compType
    }).catch(() => {});
  }

  function equip(hash) {
    axios.post(`https://${GetParentResourceName()}/equipStoredTack`, {
      horseId,
      compType,
      compHash: hash
    }).catch(() => {});
  }

  function renderTypes() {
    return Object.keys(TackColumnByType).map((typeName) => {
      const storedList = getStoredList(typeName);

      if (!storedList.length) return null;

      return (
        <span key={typeName} onClick={() => setCompType(typeName)}>
          <label>{typeName}</label>
          <i className="price">{storedList.length} stored</i>
        </span>
      );
    });
  }

  function renderStoredItems() {
    const storedList = getStoredList(compType);

    if (!storedList.length) {
      return (
        <span>
          <label>No stored {compType}</label>
        </span>
      );
    }

    return storedList.map((hash, index) => (
      <span key={`${compType}-${hash}-${index}`} onClick={() => preview(hash)}>
        <label>
          {compType} #{index + 1} {selectedHash === hash ? "◄ Selected ►" : ""}
        </label>
        <i className="price">{hash}</i>
        <button onClick={(e) => {
          e.stopPropagation();
          equip(hash);
        }}>
          Equip
        </button>
      </span>
    ));
  }

  return (
    <div className="menu-wrap">
      <h1>{compType || "Stored Tack"}</h1>
      <menu>
        {!compType && renderTypes()}
        {compType && renderStoredItems()}
      </menu>
    </div>
  );
}

export default TackStorageMenu;