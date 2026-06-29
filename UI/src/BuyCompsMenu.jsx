import { useContext, useEffect, useState } from "react";
import { Data, RouteCtx } from "./App";
import axios from "axios";

function BuyCompsMenu({ Comps = {}, buyable, horseId }) {
  const setRoute = useContext(RouteCtx);

  const [section, setSection] = useState(null);     // Hair / Tack
  const [compType, setCompType] = useState(null);    //Manes / Tails / Saddles
  const [group, setGroup] = useState(null);         // Short Manes / Trail Saddles
  const [model, setModel] = useState(null);

  useEffect(() => {
    if (!model) return;

    axios.post(`https://${GetParentResourceName()}/viewComp`, {
      modelHash: model.variants[model.v],
      type: compType.name,
    }).catch(() => {});
  }, [model]);

  useEffect(() => {
    document.onkeydown = (e) => {
      if (e.key === "Backspace") {
        setModel(null);

        if (group) return setGroup(null);
        if (compType) return setCompType(null);
        if (section) return setSection(null);

        setRoute("/myrides");
      }

      if (e.key === "ArrowLeft" && model) {
        setModel(m => ({
          ...m,
          v: m.v === 0 ? m.variants.length - 2 : m.v - 1
        }));
      }

      if (e.key === "ArrowRight" && model) {
        setModel(m => ({
          ...m,
          v: m.v === m.variants.length - 2 ? 0 : m.v + 1
        }));
      }
    };
  });

  function getPrice(variants) {
    return variants.at(-1);
  }

  function getHash(variants, index) {
    return variants[index];
  }

  function buySelected(variants) {
    if (!model) return;

    axios.post(`https://${GetParentResourceName()}/buyComp`, {
      compType: compType.name,
      compModel: getHash(variants, model.v),
      price: buyable ? getPrice(variants) : 0,
      horseId
    }).catch(() => {});
  }

function title() {
  if (group) return group.name;
  if (compType) return compType.name;
  if (section) return section.name;
  return "Equipment";
}

  function renderSections() {
    return Object.entries(Comps).map(([sectionName, sectionData]) => (
      <span key={sectionName} onClick={() => setSection({ name: sectionName, data: sectionData })}>
        <label>{sectionName}</label>
      </span>
    ));
  }

  function renderCompTypes() {
    return Object.entries(section.data).map(([typeName, typeData]) => (
      <span key={typeName} onClick={() => setCompType({ name: typeName, data: typeData })}>
        <label>{typeName}</label>
      </span>
    ));
  }

  function renderGroups() {
    return Object.entries(compType.data).map(([groupName, variants]) => (
      <span key={groupName} onClick={() => setGroup({ name: groupName, variants })}>
        <label>{groupName}</label>
        <i className="price">{Data.Lang.DollarBeforeOrAfterPrice.replace("{price}", getPrice(variants))}</i>
      </span>
    ));
  }

  function renderVariants() {
    return group.variants
      .slice(0, -1)
      .map((hash, index) => (
        <span key={`${group.name}-${index}`} onClick={() => setModel({ variants: group.variants, v: index })}>
          <label>{group.name} {model?.v === index ? `◄ ${index + 1} ►` : `#${index + 1}`}</label>
          <button onClick={(e) => {
            e.stopPropagation();
            buySelected(group.variants);
          }}>
            {buyable
              ? Data.Lang.BuyFor.replace("{price}", getPrice(group.variants))
              : Data.Lang.Equip}
          </button>
        </span>
      ));
  }

  return (
    <div className="menu-wrap">
      <h1>{title()}</h1>
      <menu>
        {!section && renderSections()}
        {section && !compType && renderCompTypes()}
        {section && compType && !group && renderGroups()}
        {section && compType && group && renderVariants()}
      </menu>
    </div>
  );
}

export default BuyCompsMenu;