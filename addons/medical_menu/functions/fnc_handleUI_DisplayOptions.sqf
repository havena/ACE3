/*
 * Author: Glowbal
 * Display the available treatment options in category
 *
 * Arguments:
 * 0: Category name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["some category"] call ace_medical_menu_handleUI_DisplayOptions
 *
 * Public: No
 */
#include "script_component.hpp"

#define START_IDC 20
#define END_IDC 27
#define AMOUNT_OF_ENTRIES (count _entries)

if (!hasInterface) exitwith{};

private ["_entries", "_display", "_newTarget", "_card", "_ctrl", "_code"];

params ["_name"];

disableSerialization;

_display = uiNamespace getVariable QGVAR(medicalMenu);
if (isNil "_display") exitwith {}; // no valid dialog present

if (_name isEqualTo "toggle") exitwith {
    if (GVAR(INTERACTION_TARGET) != ACE_player) then {
        _newTarget = ACE_player;
    } else {
        _newTarget = GVAR(INTERACTION_TARGET_PREVIOUS);
    };

    GVAR(INTERACTION_TARGET_PREVIOUS) = GVAR(INTERACTION_TARGET);
    [_newTarget] spawn {
        closeDialog 0;
        sleep 0.1;
        [_this select 0] call FUNC(openMenu);
    };
};

// Clean the dropdown options list from all actions
for [{_x = START_IDC}, {_x <= END_IDC}, {_x = _x + 1}] do {
    _ctrl = (_display displayCtrl (_x));
    _ctrl ctrlSetText "";
    _ctrl ctrlShow false;
    _ctrl ctrlSetEventHandler ["ButtonClick",""];
    _ctrl ctrlSetTooltip "";
    _ctrl ctrlCommit 0;
};

GVAR(LatestDisplayOptionMenu) = _name;

// The triage card has no options available
lbClear 212;
if (_name isEqualTo "triage") exitwith {

    ctrlEnable [212, true];
    private ["_log", "_triageCardTexts", "_message"];
    _log = GVAR(INTERACTION_TARGET) getvariable [QEGVAR(medical,triageCard), []];
    _triageCardTexts = [];
    {
        _x params ["_item", "_amount", "_time"];
        _message = _item;
        if (isClass(configFile >> "CfgWeapons" >> _item)) then {
            _message = getText(configFile >> "CfgWeapons" >> _item >> "DisplayName");
        } else {
            if (isLocalized _message) then {
                _message = localize _message;
            };
        };
        _triageCardTexts pushback format["%1x - %2 (%3m)", _amount, _message, round((ACE_time - _time) / 60)];
        nil;
    }count _log;

    if (count _triageCardTexts == 0) exitwith {
        lbAdd [212,(localize ELSTRING(medical,TriageCard_NoEntry))];
    };
    {
        lbAdd [212,_x];
        nil;
    }count _triageCardTexts;
};

ctrlEnable [212, false];

_entries = [ACE_player, GVAR(INTERACTION_TARGET), _name] call FUNC(getTreatmentOptions);

{
    //player sidechat format["TRIGGERED: %1",_x];
    if (_forEachIndex > END_IDC) exitwith {};
    _ctrl = (_display displayCtrl (START_IDC + _forEachIndex));
    if (!(_forEachIndex > AMOUNT_OF_ENTRIES)) then {
        _ctrl ctrlSetText (_x select 0);
        _code = format ["ace_medical_menu_pendingReopen = true; call %1;", (_x select 3)];
        _ctrl ctrlSetEventHandler ["ButtonClick", _code];
        _ctrl ctrlSetTooltip (_x select 0); // TODO implement
        _ctrl ctrlShow true;
    } else {
        _ctrl ctrlSetText "";
        _ctrl ctrlSetEventHandler ["ButtonClick", ""];
    };
    _ctrl ctrlCommit 0;
} forEach _entries;