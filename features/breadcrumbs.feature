Feature: Attaching a series of notable events leading up to errors
    A breadcrumb contains supplementary data which will be sent along with
    events. Breadcrumbs are intended to be pieces of information which can
    lead the developer to the cause of the event being reported.

Background:
    Given I set environment variable "BUGSNAG_API_KEY" to "a35a2a72bd230ac0aa0f52715bbdc6aa"

    Scenario: Manually leaving a breadcrumb of a discarded type and discarding automatic
        When I run "DiscardedBreadcrumbTypeScenario"
        And I wait for a request
        Then the event breadcrumbs contain "Noisy event"
        And the event breadcrumbs contain "Important event"
        And the event breadcrumbs do not contain "Bugsnag loaded"

    Scenario: Leaving breadcrumbs when enabledBreadcrumbTypes is empty
        When I run "EnabledBreadcrumbTypesIsNilScenario"
        And I wait for a request
        Then the event breadcrumbs contain "Noisy event"
        And the event breadcrumbs contain "Important event"
        And the event breadcrumbs contain "Bugsnag loaded"

    Scenario: An app lauches and subsequently sends a manual event using notify()
        And I run "HandledErrorScenario"
        And I wait for a request
        Then the event breadcrumbs contain "Bugsnag loaded" with type "state"

    Scenario: An app lauches and subsequently crashes
        And I crash the app using "BuiltinTrapScenario"
        And I relaunch the app
        And I wait for a request
        Then the event breadcrumbs contain "Bugsnag loaded" with type "state"

    Scenario: Modifying a breadcrumb name
        When I run "ModifyBreadcrumbScenario"
        And I wait for a request
        Then the event breadcrumbs contain "Cache locked"

    Scenario: Modifying a breadcrumb name in callback
        When I run "ModifyBreadcrumbInNotify"
        And I wait for a request
        Then the event breadcrumbs contain "Cache locked"
