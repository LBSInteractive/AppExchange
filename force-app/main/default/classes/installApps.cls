global class installApps implements InstallHandler {

    global void onInstall(InstallContext context) {

        Datetime timeNow = System.now();
        trmScheduler nextScheduler = new trmScheduler();
        String chron_exp = '0 0 0 * * ? *';
        System.schedule('Log: ' + timeNow.getTime(), chron_exp, nextScheduler);

    }

}