import QtQml 2.0
import com.qownnotes.noteapi 1.0

/**
 * This script creates a menu item and a button to create or jump to the current date's journal entry
 */
QtObject {
    /**
     * Initializes the custom action
     */
    function init() {
        script.registerCustomAction("gitPush", "Attempt git push", "git push", "task-new");
    }

    /**
     * This function is invoked when a custom action is triggered
     * in the menu or via button
     *
     * @param identifier string the identifier defined in registerCustomAction
     */
    function customActionInvoked(identifier) {
        script.log("customActionInvoked - " + identifier);

        if (identifier != "gitPush") {
            return;
        }

        var gitExecutablePath = script.getApplicationSettingsVariable("gitExecutablePath", "git");
        if  (gitExecutablePath === '') {
            gitExecutablePath = 'git';
        }

        var notesRootPath = script.currentNoteFolderPath();


        script.log(notesRootPath);
        script.log(gitExecutablePath);

        var result = script.startSynchronousProcess(gitExecutablePath, ["-C", notesRootPath, "status", "-sb"]);
        script.log(result);

        var result2 = script.startSynchronousProcess(gitExecutablePath, ["-C", notesRootPath, "log"]);
        //script.log(result2);

        var result3 = script.startSynchronousProcess(gitExecutablePath, ["-C", notesRootPath, "push", "origin", "master"]);
        script.log(result3);

    }
}
