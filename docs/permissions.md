# Permissions Matrix

This document defines the fine-grained authorization rules for each role in the Wheelhouse system using Pundit.

## Summary of Roles
* __Owner:__ Full administrative access to all resources and historical records.
* __Counter Clerk:__ Front-desk management of customers, bikes, and active repairs.
* __Mechanic:__ Restricted access to view and update only their assigned active repairs.

## Services (StandardService)
| Action | Owner | Counter Clerk | Mechanic | Public (Unauthenticated) |
|  :---  | :---: |     :---:     |  :---:   |          :---:           |
|__Index__| Yes | Yes | Yes | Yes |
|__Show__ | Yes | Yes | Yes | Yes |
|__Create__ | Yes | No | No | No |
| __Update__ | Yes | No | No | No |
| __Destroy__ | Yes | No | No | No |


## Staff/Employees 
| Action | Owner | Counter Clerk | Mechanic |
|  :---  | :---: |     :---:     |  :---:   |
|__Index__| Yes | Yes | Yes |
|__Show__ | Yes | Yes | Yes |
|__Create__ | Yes | No | No |
| __Update__ | Yes | No | No |
| __Destroy__ | Yes | No | No|

## Customers
| Action | Owner | Counter Clerk | Mechanic |
|  :---  | :---: |     :---:     |  :---:   |
|__Index__| Yes | Yes | No (403 Forbidden) |
|__Show__ | Yes | Yes | No (403 Forbidden) |
|__Create__ | Yes | Yes | No |
| __Update__ | Yes | Yes | No |
| __Destroy__ | Yes | No | No|

## Bikes
| Action | Owner | Counter Clerk | Mechanic |
|  :---  | :---: |     :---:     |  :---:   |
|__Index__| Yes | Yes | No (403 Forbidden) |
|__Show__ | Yes | Yes | No (403 Forbidden) |
|__Create__ | Yes | Yes | No |
| __Update__ | Yes | Yes | No |
| __Destroy__ | Yes | No | No|

## Repairs
| Action | Owner | Counter Clerk | Mechanic |
|  :---  | :---: |     :---:     |  :---:   |
|__Index__| All repairs | All repairs | Only assigned repairs |
|__Show__ | All repairs | All repairs | Only assigned repairs |
|__Create__ | Yes | Yes | No |
| __Update__ | Yes | Yes (if not handed back) | Only assigned and active repairs |
| __Destroy__ | Yes | No | No|
| __Remove Photo__| Yes | Yes (if not handed back) | No |

