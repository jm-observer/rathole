use clap::{AppSettings, ArgGroup, Parser};
use lazy_static::lazy_static;

#[derive(clap::ArgEnum, Clone, Debug, Copy)]
pub enum KeypairType {
    X25519,
    X448,
}

lazy_static! {
    static ref VERSION: &'static str =
        "todo";
    static ref LONG_VERSION: String = format!(
        "
Build Timestamp:     {}
Build Version:       {}
Commit SHA:          {:?}
Commit Date:         {:?}
Commit Branch:       {:?}
cargo Target Triple: {}
cargo Profile:       {}
cargo Features:      {}
",
        "todo",
        "todo",
        "todo",
        "todo",
        "todo",
        "todo",
        "todo",
        "todo"
    );
}

#[derive(Parser, Debug, Default, Clone)]
#[clap(
    about,
    version(*VERSION),
    long_version(LONG_VERSION.as_str()),
    setting(AppSettings::DeriveDisplayOrder)
)]
#[clap(group(
            ArgGroup::new("cmds")
                .required(true)
                .args(&["CONFIG", "genkey"]),
        ))]
pub struct Cli {
    /// The path to the configuration file
    ///
    /// Running as a client or a server is automatically determined
    /// according to the configuration file.
    #[clap(parse(from_os_str), name = "CONFIG")]
    pub config_path: Option<std::path::PathBuf>,

    /// Run as a server
    #[clap(long, short, group = "mode")]
    pub server: bool,

    /// Run as a client
    #[clap(long, short, group = "mode")]
    pub client: bool,

    /// Generate a keypair for the use of the noise protocol
    ///
    /// The DH function to use is x25519
    #[clap(long, arg_enum, value_name = "CURVE")]
    pub genkey: Option<Option<KeypairType>>,
}
