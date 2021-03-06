/*
 * Author: Glowbal, Ruthberg
 * Module for adjusting the advanced ballistics settings
 *
 * Arguments:
 * 0: The module logic <LOGIC>
 * 1: units <ARRAY>
 * 2: activated <BOOL>
 *
 * Return Value:
 * None <NIL>
 *
 * Public: No
 */

#include "script_component.hpp"

private ["_logic", "_units", "_activated"];
_logic = _this select 0;
_units = _this select 1;
_activated = _this select 2;

if !(_activated) exitWith {};

[_logic, QGVAR(enabled), "enabled"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(ammoTemperatureEnabled), "ammoTemperatureEnabled"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(barrelLengthInfluenceEnabled), "barrelLengthInfluenceEnabled"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(bulletTraceEnabled), "bulletTraceEnabled"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(onlyActiveForLocalPlayers), "onlyActiveForLocalPlayers"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(disabledInFullAutoMode), "disabledInFullAutoMode"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(alwaysSimulateForSnipers), "alwaysSimulateForSnipers"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(alwaysSimulateForGroupMembers), "alwaysSimulateForGroupMembers"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(simulationInterval), "simulationInterval"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(simulationRadius), "simulationRadius"] call EFUNC(common,readSettingFromModule);

GVAR(simulationInterval) = 0 max GVAR(simulationInterval) min 0.2;
